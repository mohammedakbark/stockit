import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/labtest_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booking.dart';

class LabListPage extends StatefulWidget {
  String selectedCategory;
  LabListPage({super.key, required this.selectedCategory});

  @override
  State<LabListPage> createState() => _LabListPageState();
}

class _LabListPageState extends State<LabListPage> {
  @override
  Widget build(BuildContext context) {
    log(widget.selectedCategory);
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
              image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 89),
          child: Container(
            height: 400,
            width: 400,
            color: const Color.fromARGB(178, 233, 231, 231),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                  width: 30,
                ),
                // SizedBox(
                //   height: 50,
                //   width: 350,
                //   child: TextField(
                //     cursorColor: Colors.black,
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10)),
                //         fillColor: const Color.fromARGB(255, 237, 234, 234),
                //         filled: true,
                //         prefixIcon: const Icon(
                //           Icons.search,
                //           size: 35,
                //         ),
                //         hintText: ('Search for test and pakages')),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 100, top: 10),
                  child: Text(
                    'Recommended Packages',
                    style: GoogleFonts.abrilFatface(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: DbController().getSelectedNeethiProductByCategory(
                            widget.selectedCategory,Provider.of<DbController>(context,listen: false).currentStoreid!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                                                        log(snapshot.data!.docs.length.toString());


                          List<LabtestModel> listOfLabtest = snapshot.data!.docs
                              .map((e) => LabtestModel.fromMap(
                                  e.data() as Map<String, dynamic>))
                              .toList();
                              log(listOfLabtest.length.toString());
                          if (snapshot.hasData) {
                            return listOfLabtest.isEmpty
                                ? const Center(child: Text("No Test Found"))
                                : ListView.builder(
                                    itemCount: listOfLabtest.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Container(
                                            height: 160,
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 60),
                                                  child: Text(
                                                    listOfLabtest[index]
                                                        .productname,
                                                    style: GoogleFonts
                                                        .inknutAntiqua(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Row(children: [
                                                  const Icon(
                                                    Icons.currency_rupee,
                                                    size: 25,
                                                  ),
                                                  Text(
                                                    listOfLabtest[index].price,
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                    Icons.currency_rupee,
                                                    size: 18,
                                                    color: Colors.grey[400],
                                                  ),
                                                  Text(
                                                    listOfLabtest[index].mrp,
                                                    style: TextStyle(
                                                        decorationColor:
                                                            Colors.grey[400],
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.grey[400]),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    '${listOfLabtest[index].offer}%OFF',
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: ElevatedButton(
                                                        style: const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        173,
                                                                        242,
                                                                        240))),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        BookingDetaiPage(
                                                                          type: "Lab Test",
                                                                          productId:listOfLabtest[index].id!,
                                                                        )),
                                                          );
                                                        },
                                                        child: const Text(
                                                          'Book',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                  ),
                                                ]),
                                                const Divider(
                                                    color: Colors.black),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        'images/Document.png'),
                                                    const Text(
                                                        'Reports in 10Hrs',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    const SizedBox(
                                                      width: 120,
                                                    ),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          Icons.shopping_cart,
                                                          size: 20,
                                                        ))
                                                  ],
                                                )
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
