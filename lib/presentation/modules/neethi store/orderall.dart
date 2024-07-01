import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/booking_model.dart';
import 'package:stockit/data/model/medicine_model.dart';
import 'package:stockit/data/model/notificationFromNethioOrder.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booking.dart';

class orderall extends StatefulWidget {
  const orderall({super.key});

  @override
  State<orderall> createState() => _orderallState();
}

class _orderallState extends State<orderall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width, //color: Colors.black,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
        child: StreamBuilder<QuerySnapshot>(
            stream: DbController().getMedAndProdctOrderFornethiModule(Provider.of<DbController>(context,listen: false).storeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<BookingModel> list = snapshot.data!.docs
                  .map((e) =>
                      BookingModel.fromjosn(e.data() as Map<String, dynamic>))
                  .toList();

              if (snapshot.hasData) {
                return list.isEmpty?Center(child: Text("No product"),): ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final data = list[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 244, 243, 243),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.black)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Name:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  data.name,
                                  style: GoogleFonts.abhayaLibre(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 70,
                                ),
                                const Text(
                                  'Age:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  data.age,
                                  style: GoogleFonts.abhayaLibre(fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Gender:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  data.gender,
                                  style: GoogleFonts.abhayaLibre(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 35,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Date:',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      data.date,
                                      style:
                                          GoogleFonts.abhayaLibre(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Time:',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      data.time,
                                      style:
                                          GoogleFonts.abhayaLibre(fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            FutureBuilder(
                                future: DbController().fetchSelectedItem(
                                    data.typeOfOrder == "Product"
                                        ? "Neethi Products"
                                        : "Medicine",
                                    data.productId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox();
                                  }

                                  dynamic dataas;
                                  if (data.typeOfOrder == "Product") {
                                    dataas = ProductNeethiModel.fromJson(
                                        snapshot.data!.data()
                                            as Map<String, dynamic>);
                                  } else {
                                    dataas = MedicineModel.fromJson(
                                        snapshot.data!.data()
                                            as Map<String, dynamic>);
                                  }

                                  return Row(
                                    children: [
                                      const Text(
                                        'Item:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        data.typeOfOrder == "Product"
                                            ? dataas.prodName
                                            : dataas.medName,
                                        style: GoogleFonts.abhayaLibre(
                                            fontSize: 20,
                                            color: const Color.fromARGB(
                                                255, 225, 133, 20)),
                                      ),
                                    ],
                                  );
                                }),
                            Text(
                              data.typeOfOrder == "Product" ? "" : "Medicine",
                              style: GoogleFonts.abhayaLibre(
                                  fontSize: 20,
                                  color:
                                      const Color.fromARGB(255, 225, 133, 20)),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Quantity:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '  3 strips',
                                  style: GoogleFonts.abhayaLibre(
                                      fontSize: 20, color: Colors.black),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 110),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color(0xff57C1AE))),
                                      onPressed: () {
                                         DbController()
                                                .sendNotificationToUserbookingStatusOFUser(
                                                    data.uid,
                                                    NotificationModelForNethiOrder(
                                                        from: Provider.of<
                                                                    DbController>(
                                                                context,
                                                                listen: false)
                                                            .storeId!,
                                                        toID: data.uid,
                                                        message:
                                                            "'Your Order is Confiremed '")).then((value){
                                                              DbController()
                                              .deleteBooking(
                                            data.bookingId   );
                                                            });
                                      },
                                      child: Text(
                                        'Conform',
                                        style: GoogleFonts.abyssinicaSil(
                                            fontSize: 15, color: Colors.white),
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color(0xff57C1AE))),
                                      onPressed: () {
                                         DbController()
                                                .sendNotificationToUserbookingStatusOFUser(
                                                    data.uid,
                                                    NotificationModelForNethiOrder(
                                                        from: Provider.of<
                                                                    DbController>(
                                                                context,
                                                                listen: false)
                                                            .storeId!,
                                                        toID: data.uid,
                                                        message:
                                                            "'Your Order is Cancelled '")).then((value){
                                                              DbController()
                                              .deleteBooking(
                                            data.bookingId   );
                                                            });
                                      },
                                      child: Text(
                                        'Cancell',
                                        style: GoogleFonts.abyssinicaSil(
                                            fontSize: 15,
                                            color: Colors.redAccent),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}
