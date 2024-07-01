import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/modules/neethi%20store/neallproducts.dart';
import 'package:stockit/presentation/modules/neethi%20store/neethimenu.dart';
import 'package:stockit/presentation/modules/user_module/neethi/serch_result_product.dart';

class nehealthcare extends StatefulWidget {
  const nehealthcare({super.key});

  @override
  State<nehealthcare> createState() => _nehealthcareState();
}

class _nehealthcareState extends State<nehealthcare> {
  final __nameController = TextEditingController();
  final _descriptioncontroller = TextEditingController();
  final _priceController = TextEditingController();
  final _mrpController = TextEditingController();
  final _offerController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const neethimenu(),
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
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
          'Health Care',
          style: GoogleFonts.inknutAntiqua(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
        child: StreamBuilder<QuerySnapshot>(
            stream: DbController().getSelectedNeethiProducts(Provider.of<DbController>(context,listen: false).storeId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<ProductNeethiModel> listOfNeethiProducts = snapshot
                  .data!.docs
                  .map((e) => ProductNeethiModel.fromJson(
                      e.data() as Map<String, dynamic>))
                  .toList();

              if (snapshot.hasData) {
                return listOfNeethiProducts.isEmpty
                    ? Container(
                        child: Center(
                        child: Text("No Products"),
                      ))
                    : Container(
                        height: 555,
                        width: 345,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(215, 0, 0, 0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Top Selling Categories',
                              style: GoogleFonts.inknutAntiqua(
                                  fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemCount: listOfNeethiProducts.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                          height: 90,
                                          width: 90,
                                          decoration: const BoxDecoration(
                                            color: Colors.blueGrey,
                                          ),
                                          child: Image.network(
                                            listOfNeethiProducts[index]
                                                .imageUrl,
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        listOfNeethiProducts[index].prodName,
                                        style: GoogleFonts.inknutAntiqua(
                                            fontSize: 10, color: Colors.white),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const neallproduct()));
                                },
                                child: const Text(
                                  'View All',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ));
              } else {
                return SizedBox();
              }

              // return Column(
              //   children: [
              //     const SizedBox(
              //       height: 15,
              //     ),
              //     const SizedBox(
              //       height: 15,
              //     ),
              //     Container(
              //       height: 555,
              //       width: 345,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: const Color.fromARGB(215, 0, 0, 0),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.only(top: 15, left: 17),
              //         child: Column(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(right: 85),
              //               child: Text(
              //                 'Top Selling Categories',
              //                 style: GoogleFonts.inknutAntiqua(
              //                     fontSize: 18, color: Colors.white),
              //               ),
              //             ),
              //             const SizedBox(
              //               height: 15,
              //             ),
              //             Row(
              //               children: [
              //                 Column(
              //                   children: [
              //                     GestureDetector(
              //                       child: Container(
              //                           height: 90,
              //                           width: 95,
              //                           decoration: const BoxDecoration(
              //                             color: Colors.blueGrey,
              //                           ),
              //                           child: Image.asset(
              //                             'images/glucomtr.png',
              //                             fit: BoxFit.cover,
              //                           )),
              //                     ),
              //                     Text(
              //                       'Glucometer',
              //                       style: GoogleFonts.inknutAntiqua(
              //                           fontSize: 10, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Column(
              //                   children: [
              //                     Container(
              //                         height: 90,
              //                         width: 95,
              //                         decoration: const BoxDecoration(
              //                           color: Colors.blueGrey,
              //                         ),
              //                         child: Image.asset(
              //                           'images/nutritiondrink.png',
              //                           fit: BoxFit.cover,
              //                         )),
              //                     Text(
              //                       'Nutrirional drink',
              //                       style: GoogleFonts.inknutAntiqua(
              //                           fontSize: 10, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Column(
              //                   children: [
              //                     Container(
              //                         height: 90,
              //                         width: 90,
              //                         decoration: const BoxDecoration(
              //                           color: Colors.blueGrey,
              //                         ),
              //                         child: Image.asset(
              //                           'images/vitamin.png',
              //                           fit: BoxFit.cover,
              //                         )),
              //                     Text(
              //                       'Vitamins A-Z',
              //                       style: GoogleFonts.inknutAntiqua(
              //                           fontSize: 10, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             const SizedBox(
              //               height: 8,
              //             ),
              //             Row(
              //               children: [
              //                 Column(
              //                   children: [
              //                     Container(
              //                         height: 90,
              //                         width: 95,
              //                         decoration: const BoxDecoration(
              //                           color: Colors.blueGrey,
              //                         ),
              //                         child: Image.asset(
              //                           'images/baby.png',
              //                           fit: BoxFit.cover,
              //                         )),
              //                     Text(
              //                       'Baby skin care',
              //                       style: GoogleFonts.inknutAntiqua(
              //                           fontSize: 10, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Column(
              //                   children: [
              //                     Container(
              //                         height: 90,
              //                         width: 95,
              //                         decoration: const BoxDecoration(
              //                           color: Colors.blueGrey,
              //                         ),
              //                         child: Image.asset(
              //                           'images/adult.png',
              //                           fit: BoxFit.cover,
              //                         )),
              //                     Text(
              //                       'Adult Diaper',
              //                       style: GoogleFonts.inknutAntiqua(
              //                           fontSize: 10, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Column(
              //                   children: [
              //                     Container(
              //                         height: 90,
              //                         width: 90,
              //                         decoration: const BoxDecoration(
              //                           color: Colors.blueGrey,
              //                         ),
              //                         child: Image.asset(
              //                           'images/oral.png',
              //                           fit: BoxFit.cover,
              //                         )),
              //                     Text(
              //                       'Oral product',
              //                       style: GoogleFonts.inknutAntiqua(
              //                           fontSize: 10, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             const SizedBox(
              //               height: 8,
              //             ),
              //             Row(
              //               children: [
              //                 Column(
              //                   children: [
              //                     Container(
              //                         height: 90,
              //                         width: 95,
              //                         decoration: const BoxDecoration(
              //                           color: Colors.blueGrey,
              //                         ),
              //                         child: Image.asset(
              //                           'images/women.png',
              //                           fit: BoxFit.cover,
              //                         )),
              //                     Text(
              //                       'women care',
              //                       style: GoogleFonts.inknutAntiqua(
              //                           fontSize: 10, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Column(
              //                   children: [
              //                     Container(
              //                         height: 90,
              //                         width: 95,
              //                         decoration: const BoxDecoration(
              //                           color: Colors.blueGrey,
              //                         ),
              //                         child: Image.asset(
              //                           'images/babydiapr.png',
              //                           fit: BoxFit.cover,
              //                         )),
              //                     Text(
              //                       'Baby Diaper',
              //                       style: GoogleFonts.inknutAntiqua(
              //                           fontSize: 10, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Column(
              //                   children: [
              //                     Container(
              //                         height: 90,
              //                         width: 90,
              //                         decoration: const BoxDecoration(
              //                           color: Colors.blueGrey,
              //                         ),
              //                         child: Image.asset(
              //                           'images/viks.png',
              //                           fit: BoxFit.cover,
              //                         )),
              //                     Text(
              //                       'Respiratory Care',
              //                       style: GoogleFonts.inknutAntiqua(
              //                           fontSize: 10, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             Padding(
              //               padding:
              //                   const EdgeInsets.only(top: 120, left: 180),
              //               child: TextButton(
              //                   onPressed: () {
              //                     Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                             builder: (context) =>
              //                                 const neallproduct()));
              //                   },
              //                   child: const Text(
              //                     'View All',
              //                     style: TextStyle(color: Colors.white),
              //                   )),
              //             )
              //           ],
              //         ),
              //       ),
              //     )
              //   ],
              // );
            }),
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
                height: 400,
                width: double.infinity,
                child: Form(
                  key: _formKey,
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
                              builder: (context, controller, chuld) {
                            return Stack(
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: controller.fileImage != null
                                              ? FileImage(controller.fileImage!)
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
                                        onPressed: () {
                                          controller
                                              .pickeImageFromGallery()
                                              .then((value) {
                                            pickedFile = controller.fileImage;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.black,
                                          size: 30,
                                        )),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 50),
                                child: SizedBox(
                                  height: 65,
                                  width: 150,
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
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 100),
                                child: Text(
                                  'Description',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 65,
                                width: 200,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _descriptioncontroller,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please type product details';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                    fillColor: const Color.fromARGB(
                                        177, 255, 255, 255),
                                    filled: true,
                                    hintText: ('Product details'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 50),
                                child: Text(
                                  'MRP',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 65,
                                width: 100,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _mrpController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'MRP';
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
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                    fillColor: const Color.fromARGB(
                                        177, 255, 255, 255),
                                    filled: true,
                                    hintText: ('MRP'),
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
                                padding: EdgeInsets.only(right: 40),
                                child: Text(
                                  'OFFER %',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 65,
                                width: 100,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _offerController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Offer%';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                    fillColor: const Color.fromARGB(
                                        177, 255, 255, 255),
                                    filled: true,
                                    hintText: ('Offer%'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              const Text(
                                'Price',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 65,
                                width: 100,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _priceController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Sale price';
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
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                    fillColor: const Color.fromARGB(
                                        177, 255, 255, 255),
                                    filled: true,
                                    hintText: ('Price'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Consumer<Controller>(
                          builder: (context, contrller, child) {
                        return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (pickedFile != null) {
                                  contrller
                                      .storeImage(pickedFile!, "NeethiProduct")
                                      .then((url) {
                                    DbController()
                                        .addProduct(ProductNeethiModel(
                                          storeId:Provider.of<DbController>(context,listen: false).storeId!,
                                      prodName: __nameController.text,
                                      description: _descriptioncontroller.text,
                                      imageUrl: url,
                                      mrp: _mrpController.text,
                                      offer: _offerController.text,
                                      price: _priceController.text,
                                    ));
                                    _mrpController.clear();
                                    __nameController.clear();
                                    _offerController.clear();
                                    _priceController.clear();
                                    _descriptioncontroller.clear();
                                    contrller.fileImage = null;
                                    Navigator.pop(context);
                                  });
                                } else {
                                  Services.errorMessage(context, "Pick Image");
                                }
                              }
                            },
                            child: const Text('Submit'));
                      })
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
