import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/order_model.dart';
import 'package:stockit/presentation/modules/mavelistore%20module/mavorderview.dart';

class mavelimoduleorder extends StatefulWidget {
  const mavelimoduleorder({super.key});

  @override
  State<mavelimoduleorder> createState() => _mavelimoduleorderState();
}

class _mavelimoduleorderState extends State<mavelimoduleorder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu),),
        title: Text('Orders',style: GoogleFonts.abrilFatface(fontSize:20,color:Colors.black),),
      backgroundColor: Colors.white),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/image 5.png'), fit: BoxFit.cover)),
        child: StreamBuilder<QuerySnapshot>(
            stream: DbController().getOrderInStore(
                Provider.of<DbController>(context, listen: false).storeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<OrderModel> ordeList = [];
              ordeList = snapshot.data!.docs
                  .map((e) =>
                      OrderModel.fromJosn(e.data() as Map<String, dynamic>))
                  .toList();
              if (snapshot.hasData) {
                return ordeList.isEmpty?const Center(child: const Text("No Orders"),): ListView.builder(
                  itemCount: ordeList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => mavorderview(
                                        orderId:
                                            ordeList[index].orderId!
                                                ,
                                      )));
                        },
                        child: FutureBuilder(
                            future: DbController()
                                .getSelectedUserdata(ordeList[index].uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              final data = snapshot.data;
                              return Container(
                                height: 130,
                                width: 250,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 43,
                                      child: data!["image"] != ""
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(data["image"]),
                                              radius: 40,
                                            )
                                          : const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'images/Ellipse 4.png'),
                                              radius: 40,
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["name"],
                                          style: GoogleFonts.abrilFatface(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Card No. N/A",
                                          style: GoogleFonts.abyssinicaSil(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "No. of Persons: N/A",
                                          style: GoogleFonts.abyssinicaSil(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          ordeList[index].cardType,
                                          style: GoogleFonts.abrilFatface(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}