import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/data/provider/controller.dart';

class MySheet {
  static showMyBottomSheet(
      {context,
      formKey,
      File? selectedImage,
      TextEditingController? nameControler,
      TextEditingController? priceController,
      TextEditingController? qntyController,
      String? module}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 80),
                    child: Text(
                      'Click + button to upload product photo',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                              padding:
                                  const EdgeInsets.only(left: 120, bottom: 150),
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
                                        selectedImage = controller.fileImage;
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 65,
                            width: 200,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: nameControler,
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
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  fillColor:
                                      const Color.fromARGB(177, 255, 255, 255),
                                  filled: true,
                                  hintText: ('Product name')),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Consumer<Controller>(builder: (context, controller, child) {
                    return Row(
                      children: [
                        SizedBox(
                          width: Services.w(context) * .4,
                          child: RadioListTile(
                              title: Text("Genaral"),
                              value: "Genaral",
                              groupValue: controller.radioValue,
                              onChanged: controller.chanegeRadioButtonvalues),
                        ),
                        SizedBox(
                            width: Services.w(context) * .4,
                            child: RadioListTile(
                                title: Text("Special"),
                                value: "Special",
                                groupValue: controller.radioValue,
                                onChanged:
                                    controller.chanegeRadioButtonvalues)),
                      ],
                    );
                  }),
                  Row(
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 100),
                            child: Text(
                              'Price',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 65,
                            width: 150,
                            child: TextFormField(maxLength: 4,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: priceController,
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
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                fillColor:
                                    const Color.fromARGB(177, 255, 255, 255),
                                filled: true,
                                hintText: ('Price'),
                                prefixIcon: const Icon(Icons.currency_rupee),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 65,
                            width: 150,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: qntyController,
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
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                fillColor:
                                    const Color.fromARGB(177, 255, 255, 255),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 150),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (selectedImage != null) {
                                      Controller()
                                          .storeImage(
                                              selectedImage!, "ProductImage")
                                          .then((url) {
                                        Navigator.pop(context);
                                        if (module == "Maveli") {
                                          DbController()
                                              .addProductToMaveliStore(
                                                  StoreProductModel(
                                                      isItSpecial: Provider.of<
                                                                  Controller>(
                                                              context,
                                                              listen: false)
                                                          .radioValue,
                                                      category: "",
                                                      imageUrl: url,
                                                      price:
                                                          priceController!.text,
                                                      productName:
                                                          nameControler!.text,
                                                      qty: int.parse(
                                                          qntyController!.text),
                                                      storeId: Provider.of<
                                                                  DbController>(
                                                              context,
                                                              listen: false)
                                                          .storeId!));
                                        } else {
                                          DbController()
                                              .addProductToSupplycoStore(
                                                  StoreProductModel(
                                                      isItSpecial: Provider.of<
                                                                  Controller>(
                                                              context,
                                                              listen: false)
                                                          .radioValue,
                                                      category: "",
                                                      imageUrl: url,
                                                      price:
                                                          priceController!.text,
                                                      productName:
                                                          nameControler!.text,
                                                      qty: int.parse(
                                                          qntyController!.text),
                                                      storeId: Provider.of<
                                                                  DbController>(
                                                              context,
                                                              listen: false)
                                                          .storeId!));
                                        }
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
  }
}
