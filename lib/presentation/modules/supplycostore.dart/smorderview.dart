import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/data/model/notification_model.dart';
import 'package:stockit/data/model/order_model.dart';

class smorderview extends StatefulWidget {
  String orderId;
   smorderview({super.key,required this.orderId});

  @override
  State<smorderview> createState() => _smorderviewState();
}

class _smorderviewState extends State<smorderview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(onPressed: (){
          Navigator.pop(context);
         }, icon:Icon(Icons.arrow_back_ios_sharp) ),
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
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: DbController()
                          .getSelectedOrderInStore(widget.orderId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        OrderModel orderModel;
                        orderModel = OrderModel.fromJosn(
                            snapshot.data!.data() as Map<String, dynamic>);
                        // log(orderModel.toString());
                        return orderModel.storeProductModel.isEmpty
                            ? Center(
                                child: Text("No Data"),
                              )
                            : ListView.builder(
                                itemCount: orderModel.storeProductModel.length,
                                itemBuilder: (context, index) {
                                  StoreProductModel data =
                                      orderModel.storeProductModel[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 15, right: 15),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                185, 255, 255, 255)),
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
                                                      data.imageUrl)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, bottom: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(data.productName,
                                                      style: GoogleFonts
                                                          .inknutAntiqua(
                                                              fontSize: 20)),
                                                  Row(
                                                    children: [
                                                      Icon(Icons
                                                          .currency_rupee_sharp),
                                                      Text(
                                                        '${data.price}/Kg',
                                                        style: TextStyle(
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
                                                        '${data.qty} Kg/Person',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  // const Padding(
                                                  //   padding: EdgeInsets.only(
                                                  //       left: 8),
                                                  //   child: Text('Date:',
                                                  //       style: TextStyle(
                                                  //           fontSize: 18,
                                                  //           fontWeight:
                                                  //               FontWeight
                                                  //                   .w500)),
                                                  // ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 60),
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              DbController().sendNotificationToUser(
                                                                  orderModel
                                                                      .uid,
                                                                  NotificationModel(
                                                                      from: Provider.of<DbController>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .storeId!,
                                                                      message:
                                                                          "${data.productName} is rejected"),
                                                                  orderModel
                                                                      .orderId,
                                                                  data);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                              Icons.cancel,
                                                              color: Colors.red,
                                                              size: 30,
                                                            )),
                                                        IconButton(
                                                            onPressed: () {
                                                              DbController().sendNotificationToUser(
                                                                  orderModel
                                                                      .uid,
                                                                  NotificationModel(
                                                                      from: Provider.of<DbController>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .storeId!,
                                                                      message:
                                                                          "${data.productName} is Accepted"),
                                                                  orderModel
                                                                      .orderId,
                                                                  data);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                              Icons.verified,
                                                              color:
                                                                  Colors.green,
                                                              size: 30,
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                });
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