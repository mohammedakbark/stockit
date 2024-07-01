import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/data/model/order_model.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/common/ordercmplt.dart';

class SpecialStockOFMaveliAndSupplyco extends StatefulWidget {
   String collection;
  String storeId;
   SpecialStockOFMaveliAndSupplyco({super.key,required this.collection,required this.storeId});

  @override
  State<SpecialStockOFMaveliAndSupplyco> createState() => _SpecialStockOFMaveliAndSupplycoState();
}

class _SpecialStockOFMaveliAndSupplycoState extends State<SpecialStockOFMaveliAndSupplyco> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   leading: IconButton(onPressed: (){
      //     //Navigator.pop(context);
      //     }, icon: Icon(Icons.menu)) ,
      //   title: Text('Special Item'),
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/image 5.png'), fit: BoxFit.cover)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 80, bottom: 30, left: 30, right: 30),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: DbController().getMaveliAndSupplycoSpecialProductForOrder(widget.collection, widget.storeId),
                  builder: (context, snapshot) {
                     if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<StoreProductModel>list=[];
                    list=snapshot.data!.docs.map((e) => StoreProductModel.fromJson(e.data()as Map<String,dynamic>)).toList();
                    if (snapshot.hasData) {
                      return list.isEmpty?Center(child: Text("No Special",style: TextStyle(color: Colors.white),),): ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => Column(
                              children: [
                                Container(
                                    height: 140,
                                    width: 400,
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
                                                  style: GoogleFonts.inknutAntiqua(
                                                      fontSize: 20)),
                                               Row(
                                                children: [
                                                  Icon(Icons.currency_rupee_sharp),
                                                  Text(
                                                    '${list[index].price}/Kg',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(left: 8),
                                                child: Text('${list[index].qty}Kg/Person',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  (Color.fromARGB(
                                                                      255,
                                                                      227,
                                                                      131,
                                                                      52))),
                                                          foregroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Colors.white)),
                                                      onPressed: () {
                                                         DbController().addNewOrder(OrderModel(
                          orderStatus: "Pending",
                          cardNumber: "",
                          name: "",
                          cardType:"",
                          numberOfMembers:0,
                          storeId: widget.storeId,
                          storeProductModel:[list[index]],
                          uid: FirebaseAuth.instance.currentUser!.uid)).then((value) {
                             Provider.of<Controller>(context,listen: false).clearList();
                             Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ordercomplt()));

                          });
                                                      },
                                                      child: Text(
                                                        'Order',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      )),
                                                      // Text('${list[]} card',style: TextStyle(fontWeight: FontWeight.bold),)
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ));


                    }else{
                      return SizedBox();
                    }
                    
                  }
                ),
              ),
            ],
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
