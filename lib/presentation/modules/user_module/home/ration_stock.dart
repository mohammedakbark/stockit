import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/data/model/order_model.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/common/ordercmplt.dart';

class RationStock extends StatefulWidget {
  String storeID;
  String selectedCard;
  String name;
  String cardNumber;
  String numberOfMembers;

  RationStock(
      {super.key,
      required this.storeID,
      required this.selectedCard,
      required this.cardNumber,
      required this.name,
      required this.numberOfMembers});

  @override
  State<RationStock> createState() => _RationStockState();
}

class _RationStockState extends State<RationStock> {
  int _selectedindex = 0;

  @override
  Widget build(BuildContext context) {
                                //  Provider.of<Controller>(context,listen: false).clearList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //    leading: IconButton(onPressed: (){
      //     Navigator.pop(context);
      //    }, icon:const Icon(Icons.arrow_back_ios_sharp) ),
      //   title: Text(
      //     'white',
      //     style: GoogleFonts.inknutAntiqua(fontSize: 30),
      //   ),
      //   backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/image 5.png'), fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(
              height: 135,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: DbController().getRationProductDataForOrder(
                      widget.storeID, widget.selectedCard),
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
                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20, bottom: 20),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                                  list[index].imageUrl)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(list[index].productName,
                                                  style:
                                                      GoogleFonts.inknutAntiqua(
                                                          fontSize: 20)),
                                              Row(
                                                children: [
                                                  Icon(Icons
                                                      .currency_rupee_sharp),
                                                  Text(
                                                    '${list[index].price}/Kg',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                    '${list[index].qty} Kg/Person',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              Consumer<Controller>(builder:
                                                  (context, controller, child) {
                                                return ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.black),
                                                        foregroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.white)),
                                                    onPressed: () {
                                                      controller.addToList(
                                                          list[index]);
                                                    },
                                                    child: controller
                                                            .choosedList
                                                            .contains(
                                                                list[index])
                                                        ? const Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          )
                                                        : const Text(
                                                            'Choose',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ));
                                              })
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ));
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
            SizedBox(
              height: 40,
              width: 130,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 227, 131, 52)),
                      foregroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    if (Provider.of<Controller>(context,listen: false).choosedList.isEmpty) {
                      Services.errorMessage(context, "Choose the item");
                    } else {
                      DbController().addNewOrder(OrderModel(
                          orderStatus: "Pending",
                          cardNumber: widget.cardNumber,
                          name: widget.name,
                          cardType: widget.selectedCard,
                          numberOfMembers: int.parse(widget.numberOfMembers),
                          storeId: widget.storeID,
                          storeProductModel:
                              Provider.of<Controller>(context,listen: false).choosedList,
                          uid: FirebaseAuth.instance.currentUser!.uid)).then((value) {
                             Provider.of<Controller>(context,listen: false).clearList();
                             Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ordercomplt()));

                          });
                    }
                   
                  },
                  child: Text(
                    'Order',
                    style: GoogleFonts.inknutAntiqua(fontSize: 20),
                  )),
            )
          ],
        ),
      ),
      // extendBody: true,
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
      //           icon: Icon(
      //             Icons.library_books_rounded,
      //             size: 35,
      //           ),
      //           label: ('Items')),
      //       const BottomNavigationBarItem(
      //           icon: Icon(Icons.production_quantity_limits_rounded, size: 35),
      //           label: ('Orders')),
      //           const BottomNavigationBarItem(
      //           icon: Icon(Icons.local_offer, size: 35),
      //           label: ('Special item')),
      //     ],
      //     currentIndex: _selectedindex,
      //     selectedItemColor: const Color.fromARGB(255, 100, 74, 1),
      //     unselectedItemColor: Colors.black,
      //     onTap: (index) {
      //       setState(() {
      //         _selectedindex = index;
      //       });
      //     }),
    );
  }
}
