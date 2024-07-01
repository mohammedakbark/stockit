import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/presentation/common/ordercmplt.dart';
import 'package:stockit/presentation/common/ratio%20nmenu.dart';
import 'package:stockit/presentation/modules/rationstore.dart/rationstoremenu.dart';

class rspecial extends StatefulWidget {
  const rspecial({super.key});

  @override
  State<rspecial> createState() => _rspecialState();
}

class _rspecialState extends State<rspecial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: const  rationstoremenu(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.menu)),
        title: Text(
          'Special Item',
          style: GoogleFonts.abrilFatface(fontSize: 20),
        ),
      ),
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
                    stream: DbController().getSpecialRationProducts( Provider.of<DbController>(context,listen: false).storeId),
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
                            itemBuilder: (context, index) => Column(
                                  children: [
                                    Container(
                                        height: 140,
                                        width: 400,
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
                                                width: 100,
                                                height: 100,
                                                child: Image.network(
                                                  fit:BoxFit.cover,
                                                    list[index].imageUrl),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, bottom: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(list[index].productName,
                                                      style: GoogleFonts
                                                          .inknutAntiqua(
                                                              fontSize: 20)),
                                                   Row(
                                                    children: [
                                                      const Icon(Icons
                                                          .currency_rupee_sharp),
                                                      Text(
                                                        '${list[index].price}/Kg',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                   Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 8),
                                                    child: Text('${list[index].qty}Kg/Person',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(list[index].category,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ));
                      } else {
                        return const SizedBox();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
