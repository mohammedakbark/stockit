import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/store_model.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/modules/admin/adminmenu.dart';

import 'package:stockit/presentation/modules/admin/widgets/hometile.dart';

class adminhome extends StatefulWidget {
  const adminhome({super.key});

  @override
  State<adminhome> createState() => _adminhomeState();
}

class _adminhomeState extends State<adminhome> {
  final __nameController = TextEditingController();
  final _storeId = TextEditingController();
  final _password = TextEditingController();
  final _baranch = TextEditingController();
  final _pincode = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _location=TextEditingController();
  String? storeType;
  File? imageFile;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          drawer: const adminmenu(),
          //extendBodyBehindAppBar: true,
          appBar: AppBar(
            bottom: const TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text('Ration'),
                  ),
                  Tab(child: Text('Maveli ')),
                  Tab(child: Text('Supplyco ')),
                  Tab(child: Text('Neethi')),
                ]),
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
              'Owners',
              style: GoogleFonts.inknutAntiqua(fontSize: 25),
            ),
            backgroundColor: const Color.fromARGB(101, 255, 255, 255),
          ),
          body: TabBarView(
            children: [
              HomeTile(
                type: "Ration",
              ),
              HomeTile(type: "Maveli"),
              HomeTile(type: 'Supplyco'),
              HomeTile(type: "Neethi")
            ],
          ),
          
           floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            mini: true,
            onPressed: () {
              showBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return DraggableScrollableSheet(
                    shouldCloseOnMinExtent: true,
                    snap: true,
                    initialChildSize: .9,
                    maxChildSize: .9,
                    minChildSize: .05,
                    expand: true,
                    builder: (context, scrollController) {
                      // scrollController.createScrollPosition()
                      return Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 80),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Add stores Details',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 25
                                        ),
                                      ),
                                      Text(
                                        'Click camera button to upload profile photo',
                                        style: TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Consumer<Controller>(
                                      builder: (context, controller, child) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: controller.fileImage != null
                                                      ? FileImage(
                                                              controller.fileImage!)
                                                          as ImageProvider
                                                      : const AssetImage(
                                                          'images/imageicon.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 90, top: 70),
                                          child: IconButton(
                                              onPressed: () {
                                                controller.pickeImageFromGallery().then((value) {
                                                  imageFile=controller.fileImage;
                                                  
                                                });
                          
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.blue,
                                                size: 28,
                                              )),
                                        ),
                                        const SizedBox(
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
                                          style:
                                              TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 30),
                                        child: SizedBox(
                                          height: 65,
                                          width: 180,
                                          child: TextFormField(
                                            autovalidateMode:
                                                AutovalidateMode.onUserInteraction,
                                            controller: __nameController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please ypur name';
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
                                                hintText: ('Name')),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 100),
                                        child: Text(
                                          'Store Id',
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
                                          controller: _storeId,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'please type store id';
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.black)),
                                            fillColor: const Color.fromARGB(
                                                177, 255, 255, 255),
                                            filled: true,
                                            hintText: ('Store Id'),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 100),
                                        child: Text(
                                          'Password',
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
                                          controller: _password,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'please type password';
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.black)),
                                            fillColor: const Color.fromARGB(
                                                177, 255, 255, 255),
                                            filled: true,
                                            hintText: ('Password'),
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
                                      const Text(
                                        'Branch & Thaluk',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 65,
                                        width: 150,
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                          controller: _baranch,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Branch Name';
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
                                            hintText: ('baranch'),
                                            
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
                                          'PIN & District',
                                          style:
                                              TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 65,
                                        width: 190,
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                          controller: _pincode,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'PIN & District';
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
                                            hintText: ('PIN & District'),
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
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 100),
                                        child: Text(
                                          'Phone num',
                                          style:
                                              TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 65,
                                        width: 170,
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                          controller: _phoneNumber,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Phone num';
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
                                            hintText: ('Phone num'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 110),
                                        child: Text(
                                          'Store',
                                          style:
                                              TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Services.w(context) * .4,
                                        child: DropdownButtonFormField(
                                            validator: (value) {
                                              if (value == null) {
                                                return 'pick the store type';
                                              }
                                              return null;
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
                                            ),
                                            items: List.from([
                                              'Ration',
                                              'Maveli',
                                              'Supplyco',
                                              'Neethi'
                                            ])
                                                .map((e) => DropdownMenuItem(
                                                    value: e, child: Text(e)))
                                                .toList(),
                                            onChanged: (selected) {
                                              storeType = selected.toString();
                                              log(storeType.toString());
                                            }),
                                      )
                                    ],
                                    
                                  ),
          
                                ],
                              ),
                                 Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right:100),
                                        child: Text(
                                          'Location',
                                          style:
                                              TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 150),
                                        child: SizedBox(
                                          height: 65,
                                          width: 220,
                                          child: TextFormField(
                                            autovalidateMode:
                                                AutovalidateMode.onUserInteraction,
                                            controller: _location,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Location';
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
                                              hintText: ('Location'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ElevatedButton(
                                  onPressed: ()async {
                                    if (_formKey.currentState!.validate()) {
                                      DbController().checkTheStoreAlredyExistorNot(_storeId.text).then((value)async {
                                        if(value==false){
                                          if (imageFile != null) {
                                        // log("message");
                                      await  Controller().storeImage(imageFile!,"storeimage").then((url) {
                                          DbController().addNewStore(StoreModel(
                                            latitude: 0,
                                            longitude: 0,
                                            branch: _baranch.text,
                                            imageUrl: url,
                                            name: __nameController.text,
                                            password: _password.text,
                                            phoneNumber: int.parse(_phoneNumber.text),
                                            pin: _pincode.text,
                                            storeId: _storeId.text,
                                          
                                            storeType: storeType!)).then((value) => Navigator.pop(context));
                          
                                        });
                          Navigator.of(context).pop();
                                      
                                      } else {
                                        Services.errorMessage(
                                            context, "Upload store image!");
                                      }
                                        }else{
                                          Services.errorMessage(context, "User is already exist,Check your store Id");
                                        }
                                      });
                                    }
                                  },
                                  child: const Text('submit'))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          );
        }
      ),
          ),
    );
    
  }
}
