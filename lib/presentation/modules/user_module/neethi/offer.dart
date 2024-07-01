import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booking.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi3.dart';
import 'package:stockit/presentation/modules/user_module/neethi/offerlab.dart';
import 'package:stockit/presentation/modules/user_module/neethi/offermedcine.dart';

class offerall extends StatefulWidget {
  const offerall({super.key});

  @override
  State<offerall> createState() => _offerallState();
}

class _offerallState extends State<offerall> {
  //int _selectedindex = 0;
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
          'Offers',
          style: GoogleFonts.inknutAntiqua(fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width, //color: Colors.black,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 110, left: 20, right: 20, bottom: 25),
          child: Container(
            color: const Color.fromARGB(178, 233, 231, 231),
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(

                      // labelColor: Color.fromARGB(
                      //                       189, 130, 240, 221),
                      tabs: [
                        Tab(
                          text: "All",
                        ),
                        Tab(
                          text: "Medicine",
                        ),
                        Tab(
                          text: "Lab Test",
                        )
                      ]),

                  Expanded(
                    child: TabBarView(children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: DbController().getAllNeethiProducts(
                              Provider.of<DbController>(context, listen: false)
                                  .currentStoreid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            List<ProductNeethiModel> list = snapshot.data!.docs
                                .map((e) => ProductNeethiModel.fromJson(
                                    e.data() as Map<String, dynamic>))
                                .toList();
                            if (snapshot.hasData) {
                              return list.isEmpty
                                  ? Center(
                                      child: Text("No Product"),
                                    )
                                  : ListView.builder(
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        var data = list[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20, bottom: 10),
                                          child: Container(
                                              height: 130,
                                              width: 350,
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
                                                      data.prodName,
                                                      style: GoogleFonts
                                                          .inknutAntiqua(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.currency_rupee,
                                                        size: 19,
                                                      ),
                                                      Text(
                                                        data.price,
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
                                                        data.mrp,
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
                                                      Text(
                                                        '${data.offer}%OFF',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 45,
                                                        width: 73,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 20),
                                                          child: ElevatedButton(
                                                              style: const ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStatePropertyAll(Color.fromARGB(
                                                                          189,
                                                                          130,
                                                                          240,
                                                                          221))),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              BookingDetaiPage(
                                                                                type: "Product",
                                                                                productId: list[index].prodictid!,
                                                                              )),
                                                                );
                                                              },
                                                              child: const Text(
                                                                  'Book',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                      color: Colors.black),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'images/Document.png',
                                                        scale: 1.5,
                                                      ),
                                                      const Text(
                                                          'Reports in 10Hrs',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 100),
                                                        child: IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.favorite,
                                                              size: 20,
                                                              color: Colors
                                                                  .amber[600],
                                                            )),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )),
                                        );
                                      });
                            } else {
                              return SizedBox();
                            }
                          }),
                      const offermedicine(),
                      const offerlab()
                    ]),
                  )

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, left: 10),
                  //   child: Row(
                  //     children: [

                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  //     child: ListView.builder(
                  //   itemCount: 5,
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: const EdgeInsets.only(
                  //           left: 20, right: 20, bottom: 10),
                  //       child: Container(
                  //           height: 130,
                  //           width: 350,
                  //           decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(10),
                  //               border:
                  //                   Border.all(width: 1, color: Colors.black)),
                  //           child: Column(
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.only(right: 60),
                  //                 child: Text(
                  //                   'Complete Heart Health Checkup',
                  //                   style: GoogleFonts.inknutAntiqua(
                  //                     fontSize: 12,
                  //                   ),
                  //                 ),
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   const Icon(
                  //                     Icons.currency_rupee,
                  //                     size: 19,
                  //                   ),
                  //                   const Text(
                  //                     '2199',
                  //                     style: TextStyle(
                  //                         fontSize: 18,
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                   const SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   Icon(
                  //                     Icons.currency_rupee,
                  //                     size: 15,
                  //                     color: Colors.grey[400],
                  //                   ),
                  //                   Text(
                  //                     '3746',
                  //                     style: TextStyle(
                  //                         decorationColor: Colors.grey[400],
                  //                         decoration: TextDecoration.lineThrough,
                  //                         fontSize: 15,
                  //                         fontWeight: FontWeight.bold,
                  //                         color: Colors.grey[400]),
                  //                   ),
                  //                   const SizedBox(width: 20),
                  //                   const Text(
                  //                     '41%OFF',
                  //                     style: TextStyle(
                  //                         color: Colors.red,
                  //                         fontSize: 18,
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 45,
                  //                     width: 73,
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.only(top: 20),
                  //                       child: ElevatedButton(
                  //                           style: const ButtonStyle(
                  //                               backgroundColor:
                  //                                   MaterialStatePropertyAll(
                  //                                       Color.fromARGB(
                  //                                           189, 130, 240, 221))),
                  //                           onPressed: () {
                  //                             Navigator.push(
                  //                               context,
                  //                               MaterialPageRoute(
                  //                                   builder: (context) =>
                  //                                       const booklab()),
                  //                             );
                  //                           },
                  //                           child: const Text('Book',
                  //                               style: TextStyle(
                  //                                   fontSize: 10,
                  //                                   color: Colors.black,
                  //                                   fontWeight:
                  //                                       FontWeight.w600))),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               const Divider(color: Colors.black),
                  //               Row(
                  //                 children: [
                  //                   Image.asset(
                  //                     'images/Document.png',
                  //                     scale: 1.5,
                  //                   ),
                  //                   const Text('Reports in 10Hrs',
                  //                       style: TextStyle(
                  //                           fontSize: 15,
                  //                           fontWeight: FontWeight.w500)),
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(left: 100),
                  //                     child: IconButton(
                  //                         onPressed: () {},
                  //                         icon: Icon(
                  //                           Icons.favorite,
                  //                           size: 20,
                  //                           color: Colors.amber[600],
                  //                         )),
                  //                   )
                  //                 ],
                  //               )
                  //             ],
                  //           )),
                  //     );
                  //   },
                  // ))
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     showUnselectedLabels: true,
      //     elevation: 0,
      //     backgroundColor: const Color.fromARGB(139, 255, 255, 255),
      //     items: [
      //       const BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.home,
      //             size: 35,
      //           ),
      //           label: ('Home')),

      //       const BottomNavigationBarItem(
      //           icon: ImageIcon(
      //         AssetImage('images/Lab Items.png'),size: 30,

      //       ),
      //       label: ('Lab Test')),
      //        const BottomNavigationBarItem(
      //           icon: ImageIcon(
      //         AssetImage('images/health.png'),size: 30,

      //       ),
      //       label: ('Health Care')),
      //       const BottomNavigationBarItem(
      //           icon: ImageIcon(
      //         AssetImage('images/Discount.png'),size: 30,

      //       ),
      //       label: ('Offer')),
      //       const BottomNavigationBarItem(
      //           icon: ImageIcon(
      //         AssetImage('images/Cart.png'),size: 30,

      //       ),
      //       label: ('Cart')),

      //     ],
      //     currentIndex: _selectedindex,
      //     selectedItemColor: const Color.fromARGB(255, 196, 145, 6),
      //     unselectedItemColor: Colors.black,
      //     onTap: (index) {
      //       setState(() {
      //         _selectedindex = index;
      //       });
      //     }),
    );
  }
}
