import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/medicine_model.dart';
import 'package:stockit/data/provider/controller.dart';

class nemedicine extends StatefulWidget {
  const nemedicine({super.key});

  @override
  State<nemedicine> createState() => _nemedicineState();
}

class _nemedicineState extends State<nemedicine> {
  // MedicineController medicineController = MedicineController();
  final __nameController = TextEditingController();
  final _detailscontroller = TextEditingController();
  final _mrpController = TextEditingController();
  final _offerController = TextEditingController();
  final _priceController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  // final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Provider.of<DbController>(context,listen: false).cleaMedicineData();
    // Future pickedImageGallery() async {
    //   final pickedImage =
    //       await ImagePicker().pickImage(source: ImageSource.gallery);
    //   if (pickedImage == null) return;

    //   selectedIamge = File(pickedImage.path);
    //   setState(() {});
    // }

    // String id = _auth.currentUser!.uid;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
            )),
        title: Text(
          'Medicines',
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
                  image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
          child: Column(
            children: [
              //SizedBox(height: 90,width: 50,),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                  height: 50,
                  width: 360,
                  child: Consumer<DbController>(
                    builder: (context,searcher,child) {
                      return TextFormField(
                        onTap: () {
                          searcher.getMyMedicineForSearch(Provider.of<DbController>(context,listen: false).storeId!);
                        },
                        onChanged: (value) {
                          searcher.searchMedicineForStore(value);
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: const Color.fromARGB(186, 255, 255, 255),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 35,
                            ),
                            hintText: ('Search for Medicines')),
                      );
                    }
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 600,
                width: 360,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(186, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black)),
                child: Column(
                  children: [
                    Consumer<DbController>(
                      builder: (context,searcher,child) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: DbController().getSelectedStoreMedicineMedicines(Provider.of<DbController>(context,listen: false).storeId!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              List<MedicineModel> list = [];
                             if(searcher.listOfMedicine.isNotEmpty){
                              list=searcher.searchResulOfMedicines;

                             }else{
                               list = snapshot.data!.docs
                                  .map((e) => MedicineModel.fromJson(
                                      e.data() as Map<String, dynamic>))
                                  .toList();
                             }
                              if (snapshot.hasData) {
                                return Expanded(
                                    child: list.isEmpty
                                        ? const Center(child: Text("No Medicines"))
                                        : ListView.separated(
                                            separatorBuilder: (context, index) =>
                                                const Divider(
                                              color: Colors.black,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 5,),
                                                      Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                    list[index]
                                                                        .imageUrl))),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Column(
                                                        children: [
                                                         Row(children: [
                                                           Text(
                                                            list[index].medName,
                                                            style: GoogleFonts
                                                                .abrilFatface(
                                                                    fontSize: 18),
                                                          ),
                                                          // Spacer(),
                                                        IconButton(
                                                                      onPressed: () =>
                                                                          _showDeleteConfirmationDialog(
                                                                              context,
                                                                              list[index]
                                                                                  .medId),
                                                                      icon: Icon(
                                                                        Icons
                                                                            .delete,
                                                                        size: 20,
                                                                        color: Colors
                                                                            .orange,
                                                                      ))
                                                         ],),
                                                          SizedBox(height: 18,),
                                                          Text(
                                                    list[index].description,
                                                    style: GoogleFonts.abrilFatface(
                                                        fontSize: 15),
                                                  ),
                        
                                                        ],
                                                      ),
                                                       
                                                    ],
                                                  ),
                                                 
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 100,
                                                      ),
                                                      const Icon(
                                                        Icons.currency_rupee,
                                                        size: 20,
                                                      ),
                                                      Text(
                                                        list[index].mrp.toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons.currency_rupee,
                                                        size: 17,
                                                        color: Colors.grey[400],
                                                      ),
                                                      Text(
                                                        list[index]
                                                            .price
                                                            .toString(),
                                                        style: TextStyle(
                                                            decorationColor:
                                                                Colors.grey[400],
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.grey[400]),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      Text(
                                                        "${list[index].offer} OFF%",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                            itemCount: list.length,
                                          ));
                              } else {
                                return const Divider();
                              }
                            });
                      }
                    )
                  ],
                ),
              )
            ],
          ),
        ),
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
              return Form(
                key: _formkey,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  height: 400,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 80),
                          child: Text(
                            'Add Product',
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
                                  GestureDetector(
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: controller.fileImage != null
                                                  ? FileImage(
                                                      controller.fileImage!)
                                                  : const NetworkImage(
                                                          'https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg')
                                                      as ImageProvider<Object>,
                                              fit: BoxFit.cover)),
                                    ),
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
                                            controller.pickeImageFromGallery();
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
                                    controller: _detailscontroller,
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
                                      hintText: (' product details'),
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
                                    'Price',
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
                                        return 'price';
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
                                  'MRP',
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
                                        return 'MRP price';
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
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                if (Provider.of<Controller>(context,
                                            listen: false)
                                        .fileImage !=
                                    null) {
                                  Provider.of<Controller>(context, listen: false)
                                      .storeImage(
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .fileImage!,
                                          "Medicines")
                                      .then((url) {
                                        log(Provider.of<DbController>(context,listen: false).storeId!);
                                    DbController().addNewMedicine(MedicineModel(
                                      storeID: Provider.of<DbController>(context,listen: false).storeId??"N/A",
                                        description: _detailscontroller.text,
                                        imageUrl: url,
                                        medName: __nameController.text,
                                        mrp: double.parse(_mrpController.text),
                                        offer: _offerController.text,
                                        price:
                                            double.parse(_priceController.text)));
                                  
                                  }).then((value) {
                                    _detailscontroller.clear();
                                    _offerController.clear();
                                    _priceController.clear();
                                    _mrpController.clear();
                                    __nameController.clear();
                                  Services.successMessage(context, "Success!");


    Navigator.of(context).pop();
                                  });
                              
                                } else {
                                  Services.errorMessage(context, "Pick Image");
                                }
                    
                                // Medicinemodel _medicinemodel = Medicinemodel(
                                //     productname: __nameController.text,
                                //     description: _detailscontroller.text,
                                //     mrp: _mrpController.text,
                                //     offer: _offerController.text,
                                //     price: _priceController.text);
                                // MedicineController _medicine =
                                //     MedicineController();
                                // String uid =
                                //     FirebaseAuth.instance.currentUser!.uid;
                                // _medicine.addMedicine(_medicinemodel, uid);
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
            DbController().deleteSelectedMedicine(id);
               Navigator.of(context).pop();
            }
                          // Close the dialog


         
            // Perform deletion logic here
            //  e.g., remove item from list, call an API
          
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

  // Future _pickImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       selectedIamge = File(pickedFile.path);
  //     });
  //   }
  // }
}
