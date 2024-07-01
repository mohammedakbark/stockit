import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/booking_model.dart';
import 'package:stockit/data/model/order_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/menunee.dart';

class orderneethi extends StatefulWidget {
  const orderneethi({super.key});

  @override
  State<orderneethi> createState() => _orderneethiState();
}

class _orderneethiState extends State<orderneethi> {
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 15),
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(232, 14, 14, 14),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 180),
                  child: Text(
                    'Orders',
                    style: GoogleFonts.inknutAntiqua(
                        fontSize: 25, color: Colors.white),
                  ),
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: DbController().fetchMyCompletdOrderOfNethi(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<BookingModel> list = snapshot.data!.docs
                              .map((e) => BookingModel.fromjosn(
                                  e.data() as Map<String, dynamic>))
                              .toList();
                          if (snapshot.hasData) {
                            return list.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No Confirmed Orders Found",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, bottom: 10),
                                        child: Container(
                                            height: 85,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8, left: 5),
                                                      child: Text(
                                                        'Ecosprine 75mg ofb 14 tabletes',
                                                        style: GoogleFonts
                                                            .inknutAntiqua(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.currency_rupee,
                                                        size: 19,
                                                      ),
                                                      const Text(
                                                        '65',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons.currency_rupee,
                                                        size: 15,
                                                        color: Colors.grey[400],
                                                      ),
                                                      Text(
                                                        '99',
                                                        style: TextStyle(
                                                            decorationColor:
                                                                Colors
                                                                    .grey[400],
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .grey[400]),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      const Text(
                                                        '66%OFF',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 45),
                                                        child: IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.favorite,
                                                              size: 26,
                                                              color: Colors
                                                                  .amber[600],
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                  );
                          } else {
                            return const SizedBox();
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
