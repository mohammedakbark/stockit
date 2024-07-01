import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/modules/rationstore.dart/rationstoremenu.dart';

import 'package:stockit/presentation/modules/rationstore.dart/rwhite.dart';

class productration extends StatefulWidget {
  const productration({super.key});

  @override
  State<productration> createState() => _productrationState();
}

class _productrationState extends State<productration> {
  int _selectedindex = 0;
  File? selectedImage;
  String? selectedCard;
  String? specialvalue = "Genaral";

  @override
  Widget build(BuildContext context) {
    final __nameController = TextEditingController();
    final _descriptioncontroller = TextEditingController();
    final _priceController = TextEditingController();
    final _quantityController = TextEditingController();
    final _categoryController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    List<String> cards = ["White", "Blue", "Pink", "Yellow"];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: const rationstoremenu(),
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text('White'),
              ),
              Tab(child: Text('Blue')),
              Tab(
                child: Text('Pink'),
              ),
              Tab(
                child: Text('Yellow'),
              )
            ],
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ));
            },
          ),
          title: Text(
            'Stocks',
            style: GoogleFonts.abrilFatface(fontSize: 20),
          ),
        ),
        body: TabBarView(
          children: [
            rwhite(
              cardType: "White",
            ),
            rwhite(
              cardType: "Blue",
            ),
            rwhite(
              cardType: "Pink",
            ),
            rwhite(
              cardType: "Yellow",
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          elevation: 0,
          mini: true,
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 80),
                            child: Text(
                              'Click + button to upload product photo',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Consumer<Controller>(
                                  builder: (context, controller, child) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: selectedImage != null
                                                  ? FileImage(selectedImage!)
                                                      as ImageProvider
                                                  : const AssetImage(
                                                      'images/imageicon.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 120, bottom: 150),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                            onPressed: () async {
                                              controller
                                                  .pickeImageFromGallery()
                                                  .then((value) {
                                                selectedImage =
                                                    controller.fileImage;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.black,
                                              size: 30,
                                            )),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 140),
                                    child: Text(
                                      'Name:',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 65,
                                    width: 200,
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: __nameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please type product name';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.black)),
                                          fillColor: const Color.fromARGB(
                                              177, 255, 255, 255),
                                          filled: true,
                                          hintText: ('Product name')),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Consumer<Controller>(
                            builder: (context,controller,child) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: Services.w(context) * .4,
                                    child: RadioListTile(
                                      title: const Text("Genaral"),
                                        value: "Genaral",
                                        groupValue: controller.radioValue,
                                        onChanged: controller.chanegeRadioButtonvalues),
                                  ),
                                  SizedBox(
                                      width: Services.w(context) * .4,
                                      child: RadioListTile(
                                                                        title: const Text("Special"),
                              
                                          value: "Special",
                                          groupValue: controller.radioValue,
                                          onChanged:controller.chanegeRadioButtonvalues)),
                                ],
                              );
                            }
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 100),
                                    child: Text(
                                      'Price',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 65,
                                    width: 150,
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: _priceController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'product price';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        fillColor: const Color.fromARGB(
                                            177, 255, 255, 255),
                                        filled: true,
                                        hintText: ('Price'),
                                        prefixIcon:
                                            const Icon(Icons.currency_rupee),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 90),
                                    child: Text(
                                      'Quantity',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 65,
                                    width: 150,
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: _quantityController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Quantity';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        fillColor: const Color.fromARGB(
                                            177, 255, 255, 255),
                                        filled: true,
                                        hintText: ('Quantity'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Category',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      // height: 65,z
                                      width: 200,
                                      child: DropdownButtonFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Pick Card";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.black)),
                                          fillColor: const Color.fromARGB(
                                              177, 255, 255, 255),
                                          filled: true,
                                          hintText: ('Category'),
                                        ),
                                        items: cards
                                            .map((e) => DropdownMenuItem(
                                                value: e, child: Text(e)))
                                            .toList(),
                                        onChanged: (value) {
                                          selectedCard = value;
                                        },
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 150),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            if (selectedImage != null) {
                                              Controller()
                                                  .storeImage(selectedImage!,
                                                      "ProductImage")
                                                  .then((url) {
                                                Navigator.pop(context);
                                                DbController().addProductToRationStore(
                                                    StoreProductModel(
                                                      isItSpecial: Provider.of<Controller>(context,listen: false).radioValue,
                                                        category: selectedCard!,
                                                        imageUrl: url,
                                                        price:
                                                            _priceController.text,
                                                        productName:
                                                            __nameController.text,
                                                        qty: int.parse(
                                                            _quantityController
                                                                .text),
                                                        storeId: Provider.of<
                                                                    DbController>(
                                                                context,
                                                                listen: false)
                                                            .storeId!));
                                              });
                                            } else {
                                              Services.errorMessage(
                                                  context, "Pick Image");
                                            }
                                          }
                                        },
                                        child: const Text("Submit")),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),

        // bottomNavigationBar: BottomNavigationBar(
        //   showUnselectedLabels: true,
        //   selectedItemColor: Color.fromARGB(255, 237, 176, 11),
        //   unselectedItemColor: Colors.black,
        //   showSelectedLabels: true,
        //   items: [
        //     BottomNavigationBarItem(
        //         backgroundColor: Colors.white,
        //         icon: IconButton(
        //             onPressed: () {},
        //             icon: Icon(
        //               Icons.home,
        //               size: 35,
        //             )),
        //         // icon: Icon(
        //         //   Icons.home,
        //         //   size: 35,
        //         // ),
        //         label: ('Home')),
        //     BottomNavigationBarItem(
        //         backgroundColor: Colors.white,
        //         icon: IconButton(
        //             onPressed: () {},
        //             icon: Icon(
        //               Icons.local_offer,
        //               size: 35,
        //             )),
        //         // icon: Icon(
        //         //   Icons.local_offer,
        //         //   size: 35,
        //         // ),
        //         label: ('Special')),
        //     BottomNavigationBarItem(
        //         backgroundColor: Colors.white,
        //         icon: IconButton(
        //             onPressed: () {},
        //             icon: Icon(
        //               Icons.library_books_rounded,
        //               size: 35,
        //             )),
        //         // icon: Icon(
        //         //   Icons.library_books_rounded,
        //         //   size: 35,
        //         // ),
        //         label: ('Orders')),
        //     BottomNavigationBarItem(
        //         backgroundColor: Colors.white,
        //         icon: IconButton(
        //             onPressed: () {},
        //             icon: Icon(
        //               Icons.person_pin,
        //               size: 35,
        //             )),
        //         // icon: Icon(
        //         //   Icons.person_pin,
        //         //   size: 35,
        //         // ),
        //         label: ('Profile')),
        //   ],
        // ),

        // bottomNavigationBar: BottomAppBar(
        //   height: 60,
        //   notchMargin: 5,
        //   shape: CircularNotchedRectangle(),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       IconButton(
        //         onPressed: () {},
        //         icon: Icon(Icons.home),
        //       ),
        //       IconButton(
        //         onPressed: () {},
        //         icon: Icon(Icons.trolley),
        //       ),
        //       IconButton(
        //         onPressed: () {},
        //         icon: Icon(Icons.search),
        //       ),
        //       IconButton(
        //         onPressed: () {},
        //         icon: Icon(Icons.person),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
