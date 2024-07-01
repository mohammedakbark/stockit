import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/presentation/modules/supplycostore.dart/smenu.dart';
import 'package:stockit/presentation/widgets/common_bottom_sheet.dart';

class smstocks extends StatefulWidget {
  const smstocks({super.key});

  @override
  State<smstocks> createState() => _smstocksState();
}

class _smstocksState extends State<smstocks> {
  File? selectedImage;
  void _showDeleteConfirmationDialog(BuildContext context,storeproductCollection,productId) {
    // Create an alert dialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete?"),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {

            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            DbController().deleteProductOfCurrentStore(storeproductCollection,productId);
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
    final __nameController = TextEditingController();
    final _descriptioncontroller = TextEditingController();
    final _priceController = TextEditingController();
    final _quantityController = TextEditingController();
    final _categoryController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    Future<void> _pickedImageGallery() async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      selectedImage = File(pickedImage.path);
      setState(() {});
    }

    return Scaffold(
      drawer: const smenu(),
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
          'Stocks',
          style: GoogleFonts.abrilFatface(fontSize: 20),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/image 5.png'), fit: BoxFit.cover)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 30, left: 30, right: 30),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: DbController().getSupplycoProduct( Provider.of<DbController>(context,listen: false).storeId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<StoreProductModel> list = [];
                      list = snapshot.data!.docs
                          .map((e) => StoreProductModel.fromJson(
                              e.data() as Map<String, dynamic>))
                          .toList();

                      if (snapshot.hasData) {
                        return list.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Products",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black),
                                                color: const Color.fromARGB(
                                                    206, 255, 255, 255)),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 10,
                                                  ),
                                                  child: SizedBox( height: 100,
                                                    width: 100,
                                                    child: Image.network(
                                                      fit: BoxFit.cover,
                                                        list[index].imageUrl),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          list[index]
                                                              .productName,
                                                          style: GoogleFonts
                                                              .inknutAntiqua(
                                                                  fontSize:
                                                                      20)),
                                                      Row(
                                                        children: [
                                                          const Icon(Icons
                                                              .currency_rupee_sharp),
                                                          Text(
                                                            '${list[index].price}/Kg',
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 8),
                                                        child: Text(
                                                            '${list[index].qty} Kg/Person',
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
                                                      // ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),foregroundColor: MaterialStatePropertyAll(Colors.white)),
                                                      // onPressed: (){}, child: const Text('Choose',style: TextStyle(fontSize: 15,),))
                                                    ],
                                                  ),
                                                ),
                                                  IconButton(onPressed: ()=>_showDeleteConfirmationDialog(context,"Supplyco Products",list[index].productId), 
                                      icon: const Icon(Icons.delete,size: 20,color: Colors.black,))
                                              ],
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                       
                                      ],
                                    ));
                      } else {
                        return const SizedBox();
                      }
                    }),
              ),
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
          MySheet.showMyBottomSheet(
              context: context,
              formKey: _formKey,
              module: "Supplyco",
              nameControler: __nameController,
              priceController: _priceController,
              qntyController: _quantityController,
              selectedImage: selectedImage);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
