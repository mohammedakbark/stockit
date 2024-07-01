import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/add_product_store.dart';

class rwhite extends StatefulWidget {
  String cardType;

  rwhite({super.key, required this.cardType});

  @override
  State<rwhite> createState() => _rwhiteState();
}

class _rwhiteState extends State<rwhite> {
   void _showDeleteConfirmationDialog(BuildContext context,productId) {
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
            DbController().deleteProductOfCurrentStore("Ration Products", productId);
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
    return Scaffold(
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
                    stream: DbController().getRationProduct(widget.cardType,    Provider.of<DbController>(context,listen: false).storeId),
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
                        return list.isEmpty?Center(child: Text("No Product",style: TextStyle(color: Colors.white),),): ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) => Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            color: const Color.fromARGB(
                                                206, 255, 255, 255)),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 10,
                                              ),
                                              child: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(
                                                  fit: BoxFit.cover,
                                                    list[index].imageUrl),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, bottom: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(list[index].productName,
                                                      style: GoogleFonts
                                                          .inknutAntiqua(
                                                              fontSize: 20)),
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
                                                    padding: const EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                        '${list[index].qty}Kg/Person',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left: 150),
                                                   child: IconButton(onPressed: ()=>_showDeleteConfirmationDialog(context,list[index].productId), 
                                                                                         icon: Icon(Icons.delete,size: 25,color: Colors.black,)),
                                                 )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    )
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
    );
  }
}
