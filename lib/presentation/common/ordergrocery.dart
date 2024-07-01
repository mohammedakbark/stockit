import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/data/model/order_model.dart';
import 'package:stockit/data/model/store_model.dart';

class ordergrocery extends StatefulWidget {
  const ordergrocery({super.key});

  @override
  State<ordergrocery> createState() => _ordergroceryState();
}

class _ordergroceryState extends State<ordergrocery> {
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
            DbController().deleteMyOrder(id);
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        title: Text(
          'Orders',
          style: GoogleFonts.abrilFatface(fontSize: 20),
        ),
        // ss
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/image 5.png'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
          child: Container(
            color: const Color.fromARGB(181, 12, 12, 12),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: DbController().getMyOrders(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        List<OrderModel> list = [];
                        list = snapshot.data!.docs
                            .map((e) => OrderModel.fromJosn(
                                e.data() as Map<String, dynamic>))
                            .toList();
                        if (snapshot.hasData) {
                          return list.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No Orders",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: list[index]
                                            .storeProductModel
                                            .length,
                                        itemBuilder: (context, index2) {
                                          StoreProductModel stock = list[index]
                                              .storeProductModel[index2];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 15, right: 15),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: const Color.fromARGB(
                                                        185, 255, 255, 255)),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        left: 10,
                                                      ),
                                                      child: SizedBox(
                                                        width: 100,
                                                        height: 100,
                                                        child: Image.network(
                                                            fit: BoxFit.cover,
                                                            stock.imageUrl),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              bottom: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              stock.productName,
                                                              style: GoogleFonts
                                                                  .inknutAntiqua(
                                                                      fontSize:
                                                                          20)),
                                                          Row(
                                                            children: [
                                                              const Icon(Icons
                                                                  .currency_rupee_sharp),
                                                              Text(
                                                                '${stock.price}/Kg',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8),
                                                            child: Text(
                                                                '${stock.qty} Kg/Person',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8),
                                                            child: Text(
                                                                stock.category,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                          Row(
                                                            children: [
                                                              FutureBuilder(
                                                                  future: DbController()
                                                                      .getSelectedStore(
                                                                          list[index]
                                                                              .storeId),
                                                                  builder: (
                                                                    context,
                                                                    snapshot,
                                                                  ) {
                                                                    if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return const SizedBox();
                                                                    }
                                                                    StoreModel
                                                                        storeModel;
                                                                    if (snapshot
                                                                        .data!
                                                                        .exists) {
                                                                      storeModel = StoreModel.fromjson(snapshot
                                                                              .data!
                                                                              .data()
                                                                          as Map<
                                                                              String,
                                                                              dynamic>);
                                                                      return Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                8),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              Services.w(context) * .3,
                                                                          child: Text(
                                                                              storeModel.branch,
                                                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return Text(
                                                                          "Store not Exist",
                                                                          style: const TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w500));
                                                                    }
                                                                  }),
                                                              //  Spacer(),
                                                              SizedBox(
                                                                  width: 5),
                                                              IconButton(
                                                                  onPressed: () =>
                                                                      _showDeleteConfirmationDialog(
                                                                          context,
                                                                          list[index]
                                                                              .orderId),
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 20,
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        139,
                                                                        12,
                                                                        12),
                                                                  ))
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          );
                                        });
                                  },
                                );
                        } else {
                          return const SizedBox();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
