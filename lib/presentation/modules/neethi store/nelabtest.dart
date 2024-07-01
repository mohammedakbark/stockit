import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/labtest_model.dart';
import 'package:stockit/presentation/modules/neethi%20store/neethimenu.dart';
import 'package:stockit/presentation/modules/user_module/neethi/labtest_list_page.dart';

class nelabtest extends StatefulWidget {
  const nelabtest({super.key});

  @override
  State<nelabtest> createState() => _nelabtestState();
}

class _nelabtestState extends State<nelabtest> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final __testnameController = TextEditingController();
  final _testdescriptioncontroller = TextEditingController();
  final _priceController = TextEditingController();
  final _offerController = TextEditingController();
  final _mrpController = TextEditingController();
  final _categoryController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  String? _selectedCategory;
  void _showDeleteConfirmationDialog(BuildContext context, id) {
    // Create an alert dialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            DbController().deleteSelectedLabTest(id);
            // Perform deletion logic here
            //  e.g., remove item from list, call an API
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    // Provider.of<DbController>(context,listen: true).cleaLabTestData();
    // DbController().cleaLabTestData();
    // String id = _auth.currentUser!.uid;
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
          'Lab Test',
          style: GoogleFonts.inknutAntiqua(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/pharmacy.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  //SizedBox(height: 90,width: 50,),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 50,
                      width: 355,
                      child: Consumer<DbController>(
                          builder: (context, seracher, child) {
                        // if( seracher.labTestSearchResult.isEmpty){
                        //   listOfData=;
                        // }
                        return TextFormField(
                          onTap: () {
                            seracher.getMyLabTest(Provider.of<DbController>(context,listen: false).storeId!);
                          },
                          onChanged: (value) {
                            seracher.searchlabTest(value);
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor:
                                  const Color.fromARGB(186, 255, 255, 255),
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 35,
                              ),
                              hintText: ('Search for test and pakages')),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 15, width: 30),
                  Container(
                    height: 600,
                    width: 355,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(186, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.black)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'images/Lab.png',
                              scale: 1.2,
                            ),
                            Text(
                              'Popular Tests',
                              style: GoogleFonts.inknutAntiqua(fontSize: 25),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<DbController>(
                            builder: (context, searcher, child) {
                          return Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: DbController()
                                      .getSelectedStoreLapTest(
                                          Provider.of<DbController>(context,
                                                  listen: false)
                                              .storeId!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    List<LabtestModel> listOfData = [];

                                    if (searcher.labTestList.isNotEmpty) {
                                      listOfData = searcher.labTestSearchResult;
                                    } else {
                                      listOfData = snapshot.data!.docs
                                          .map((e) => LabtestModel.fromMap(
                                              e.data() as Map<String, dynamic>))
                                          .toList();
                                    }
                                    if (snapshot.hasData) {
                                      return listOfData.isEmpty
                                          ? const Center(
                                              child: Text("No Lab Test"),
                                            )
                                          : ListView.builder(
                                              itemCount: listOfData.length,
                                              itemBuilder: (context, index) {
                                                var data = listOfData[index];

                                                return Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 100,
                                                              ),
                                                              Text(
                                                                data.productname,
                                                                style: GoogleFonts
                                                                    .inknutAntiqua(
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                              IconButton(
                                                                  onPressed: () =>
                                                                      _showDeleteConfirmationDialog(
                                                                          context,
                                                                          listOfData[index]
                                                                              .id),
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .orange,
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Text(
                                                            data.description,
                                                            style: GoogleFonts
                                                                .inknutAntiqua(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 30),
                                                          child: Row(children: [
                                                            const Icon(
                                                              Icons
                                                                  .currency_rupee,
                                                              size: 22,
                                                            ),
                                                            Text(
                                                              data.price,
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .currency_rupee,
                                                              size: 15,
                                                              color: Colors
                                                                  .grey[400],
                                                            ),
                                                            Text(
                                                              data.mrp,
                                                              style: TextStyle(
                                                                  decorationColor:
                                                                      Colors.grey[
                                                                          400],
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                          .grey[
                                                                      400]),
                                                            ),
                                                            const SizedBox(
                                                                width: 20),
                                                            Text(
                                                              '${data.offer}%OFF',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ]),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                        color: Colors.black)
                                                  ],
                                                );
                                              },
                                            );
                                    } else {
                                      // ignore: prefer_const_constructors
                                      return SizedBox();
                                    }
                                  }));
                        })
                      ],
                    ),
                  )
                ],
              ))),
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
              return Form(
                key: _formkey,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  height: 500,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 80),
                          child: Text(
                            'Add Product',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 100),
                                  child: Text(
                                    'Test type',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    height: 65,
                                    width: 200,
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: __testnameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please type labtes name';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          focusedBorder:
                                              const OutlineInputBorder(
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
                                          hintText: ('labtest name')),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 100),
                                  child: Text(
                                    'Description',
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
                                    controller: _testdescriptioncontroller,
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'please type labtest description';
                                    //   }
                                    //   return null;
                                    // },
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.name,
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
                                      hintText: ('Test details'),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 120),
                              child: Text(
                                'Category', // catogery :-Heart,Lungs,Liver,Kidney,joint Pain,Thyroid,Bones,Diabetes,Fever,Cancer Screening,Women                                      style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .8,
                              child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Select Category";
                                    } else {
                                      return null;
                                    }
                                  },
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
                                    hintText: ('Category'),
                                  ),
                                  items: DbController.labTest
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    _selectedCategory = value;
                                  }),
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                LabtestModel _labtestmodel = LabtestModel(
                                    storeId: Provider.of<DbController>(context,
                                            listen: false)
                                        .storeId!,
                                    category: _selectedCategory!,
                                    productname: __testnameController.text,
                                    description:
                                        _testdescriptioncontroller.text ?? "",
                                    mrp: _mrpController.text,
                                    offer: _offerController.text,
                                    price: _priceController.text);

                                DbController()
                                    .addLabtest(
                                  _labtestmodel,
                                )
                                    .then((value) {
                                  __testnameController.clear();
                                  _testdescriptioncontroller.clear();
                                  _mrpController.clear();
                                  _offerController.clear();
                                  _priceController.clear();

                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: const Text('Submit'))
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
    );
  }
}
