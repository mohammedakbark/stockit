import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/presentation/modules/neethi%20store/neallproducts.dart';
import 'package:stockit/presentation/modules/user_module/neethi/serch_result_product.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi3.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi_list.dart';

class topsellind extends StatefulWidget {
  const topsellind({super.key});

  @override
  State<topsellind> createState() => _topsellindState();
}

class _topsellindState extends State<topsellind> {
  // int _selectedindex=0;
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
        title: Text(
          'Health Care',
          style: GoogleFonts.inknutAntiqua(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            SizedBox(
              height: 50,
              width: 345,
              child: TextFormField(
                cursorColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductListPage()),
                  );
                },
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
                    hintText: ('Search for healthcare product')),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: DbController().getAllNeethiProducts(
                    Provider.of<DbController>(context, listen: false)
                        .currentStoreid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<ProductNeethiModel> listOfNeethiProducts = snapshot
                      .data!.docs
                      .map((e) => ProductNeethiModel.fromJson(
                          e.data() as Map<String, dynamic>))
                      .toList();
                  log(listOfNeethiProducts.length.toString());
                  if (snapshot.hasData) {
                    return listOfNeethiProducts.isEmpty
                        ? const Center(
                            child: Text("No Products"),
                          )
                        : Expanded(
                            child: Container(
                                height: 555,
                                width: 345,
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(215, 0, 0, 0),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Top Selling Categories',
                                      style: GoogleFonts.inknutAntiqua(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    Expanded(
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3),
                                        itemCount: listOfNeethiProducts.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Container(
                                                  height: 90,
                                                  width: 90,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.blueGrey,
                                                  ),
                                                  child: Image.network(
                                                    listOfNeethiProducts[index]
                                                        .imageUrl,
                                                    fit: BoxFit.cover,
                                                  )),
                                              Text(
                                                listOfNeethiProducts[index]
                                                    .prodName,
                                                style:
                                                    GoogleFonts.inknutAntiqua(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProductListPage()));
                                        },
                                        child: const Text(
                                          'View All',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                )),
                          );
                  } else {
                    return const SizedBox();
                  }

                  // return Column(
                  //   children: [
                  //     const SizedBox(
                  //       height: 15,
                  //     ),
                  //     const SizedBox(
                  //       height: 15,
                  //     ),
                  //     Container(
                  //       height: 555,
                  //       width: 345,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: const Color.fromARGB(215, 0, 0, 0),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(top: 15, left: 17),
                  //         child: Column(
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.only(right: 85),
                  //               child: Text(
                  //                 'Top Selling Categories',
                  //                 style: GoogleFonts.inknutAntiqua(
                  //                     fontSize: 18, color: Colors.white),
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               height: 15,
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Column(
                  //                   children: [
                  //                     GestureDetector(
                  //                       child: Container(
                  //                           height: 90,
                  //                           width: 95,
                  //                           decoration: const BoxDecoration(
                  //                             color: Colors.blueGrey,
                  //                           ),
                  //                           child: Image.asset(
                  //                             'images/glucomtr.png',
                  //                             fit: BoxFit.cover,
                  //                           )),
                  //                     ),
                  //                     Text(
                  //                       'Glucometer',
                  //                       style: GoogleFonts.inknutAntiqua(
                  //                           fontSize: 10, color: Colors.white),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Column(
                  //                   children: [
                  //                     Container(
                  //                         height: 90,
                  //                         width: 95,
                  //                         decoration: const BoxDecoration(
                  //                           color: Colors.blueGrey,
                  //                         ),
                  //                         child: Image.asset(
                  //                           'images/nutritiondrink.png',
                  //                           fit: BoxFit.cover,
                  //                         )),
                  //                     Text(
                  //                       'Nutrirional drink',
                  //                       style: GoogleFonts.inknutAntiqua(
                  //                           fontSize: 10, color: Colors.white),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Column(
                  //                   children: [
                  //                     Container(
                  //                         height: 90,
                  //                         width: 90,
                  //                         decoration: const BoxDecoration(
                  //                           color: Colors.blueGrey,
                  //                         ),
                  //                         child: Image.asset(
                  //                           'images/vitamin.png',
                  //                           fit: BoxFit.cover,
                  //                         )),
                  //                     Text(
                  //                       'Vitamins A-Z',
                  //                       style: GoogleFonts.inknutAntiqua(
                  //                           fontSize: 10, color: Colors.white),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //             const SizedBox(
                  //               height: 8,
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Column(
                  //                   children: [
                  //                     Container(
                  //                         height: 90,
                  //                         width: 95,
                  //                         decoration: const BoxDecoration(
                  //                           color: Colors.blueGrey,
                  //                         ),
                  //                         child: Image.asset(
                  //                           'images/baby.png',
                  //                           fit: BoxFit.cover,
                  //                         )),
                  //                     Text(
                  //                       'Baby skin care',
                  //                       style: GoogleFonts.inknutAntiqua(
                  //                           fontSize: 10, color: Colors.white),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Column(
                  //                   children: [
                  //                     Container(
                  //                         height: 90,
                  //                         width: 95,
                  //                         decoration: const BoxDecoration(
                  //                           color: Colors.blueGrey,
                  //                         ),
                  //                         child: Image.asset(
                  //                           'images/adult.png',
                  //                           fit: BoxFit.cover,
                  //                         )),
                  //                     Text(
                  //                       'Adult Diaper',
                  //                       style: GoogleFonts.inknutAntiqua(
                  //                           fontSize: 10, color: Colors.white),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Column(
                  //                   children: [
                  //                     Container(
                  //                         height: 90,
                  //                         width: 90,
                  //                         decoration: const BoxDecoration(
                  //                           color: Colors.blueGrey,
                  //                         ),
                  //                         child: Image.asset(
                  //                           'images/oral.png',
                  //                           fit: BoxFit.cover,
                  //                         )),
                  //                     Text(
                  //                       'Oral product',
                  //                       style: GoogleFonts.inknutAntiqua(
                  //                           fontSize: 10, color: Colors.white),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //             const SizedBox(
                  //               height: 8,
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Column(
                  //                   children: [
                  //                     Container(
                  //                         height: 90,
                  //                         width: 95,
                  //                         decoration: const BoxDecoration(
                  //                           color: Colors.blueGrey,
                  //                         ),
                  //                         child: Image.asset(
                  //                           'images/women.png',
                  //                           fit: BoxFit.cover,
                  //                         )),
                  //                     Text(
                  //                       'women care',
                  //                       style: GoogleFonts.inknutAntiqua(
                  //                           fontSize: 10, color: Colors.white),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Column(
                  //                   children: [
                  //                     Container(
                  //                         height: 90,
                  //                         width: 95,
                  //                         decoration: const BoxDecoration(
                  //                           color: Colors.blueGrey,
                  //                         ),
                  //                         child: Image.asset(
                  //                           'images/babydiapr.png',
                  //                           fit: BoxFit.cover,
                  //                         )),
                  //                     Text(
                  //                       'Baby Diaper',
                  //                       style: GoogleFonts.inknutAntiqua(
                  //                           fontSize: 10, color: Colors.white),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Column(
                  //                   children: [
                  //                     Container(
                  //                         height: 90,
                  //                         width: 90,
                  //                         decoration: const BoxDecoration(
                  //                           color: Colors.blueGrey,
                  //                         ),
                  //                         child: Image.asset(
                  //                           'images/viks.png',
                  //                           fit: BoxFit.cover,
                  //                         )),
                  //                     Text(
                  //                       'Respiratory Care',
                  //                       style: GoogleFonts.inknutAntiqua(
                  //                           fontSize: 10, color: Colors.white),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.only(top: 120, left: 180),
                  //               child: TextButton(
                  //                   onPressed: () {
                  //                     Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 const neallproduct()));
                  //                   },
                  //                   child: const Text(
                  //                     'View All',
                  //                     style: TextStyle(color: Colors.white),
                  //                   )),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // );
                }),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      // showUnselectedLabels: true,
      // elevation: 0,
      // backgroundColor: const Color.fromARGB(139, 255, 255, 255),
      // items: [
      //   const BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //         size: 35,
      //       ),
      //       label: ('Home')),

      //   const BottomNavigationBarItem(
      //       icon: ImageIcon(
      //     AssetImage('images/Lab Items.png'),size: 30,

      //   ),
      //   label: ('Lab Test')),
      //    const BottomNavigationBarItem(
      //       icon: ImageIcon(
      //     AssetImage('images/health.png'),size: 30,

      //   ),
      //   label: ('Health Care')),
      //   const BottomNavigationBarItem(
      //       icon: ImageIcon(
      //     AssetImage('images/Discount.png'),size: 30,

      //   ),
      //   label: ('Offer')),
      //   const BottomNavigationBarItem(
      //       icon: ImageIcon(
      //     AssetImage('images/Cart.png'),size: 30,

      //   ),
      //   label: ('Cart')),

      // ],
      // currentIndex: _selectedindex,
      // selectedItemColor: const Color.fromARGB(255, 196, 145, 6),
      // unselectedItemColor: Colors.black,
      // onTap: (index) {
      //   setState(() {
      //     _selectedindex = index;
      //   });
      // }),
    );
  }
}
