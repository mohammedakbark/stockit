import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/store_model.dart';
import 'package:stockit/presentation/modules/user_module/home/ration_detail_adding_page.dart';
import 'package:stockit/presentation/modules/user_module/maveli/mavelistockspclitem.dart';
import 'package:stockit/presentation/modules/user_module/user%20supplyco/supplycostocks.dart';

class favoritestore extends StatefulWidget {
  const favoritestore({super.key});

  @override
  State<favoritestore> createState() => _favoritestoreState();
}

class _favoritestoreState extends State<favoritestore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(139, 255, 255, 255),
          toolbarHeight: 50,
          title: Text(
            'Favorate Store',
            style: GoogleFonts.inknutAntiqua(fontSize: 25),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/image 5.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: DbController().getMyFavStore(
                              FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            List<StoreModel> listOfStore = [];
                            listOfStore = snapshot.data!.docs
                                .map((e) => StoreModel.fromjson(
                                    e.data() as Map<String, dynamic>))
                                .toList();
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: listOfStore.length,
                                  itemBuilder: (context, index) {
                                    final data = listOfStore[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20, right: 20),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Colors.white),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                  child: Text(
                                                '${data.branch}(${data.storeType})\nPin: ${data.pin}\nPh:${data.phoneNumber}',
                                                style:
                                                    GoogleFonts.abyssinicaSil(
                                                        fontSize: 15),
                                              )),
                                            ),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                  //elevation:MaterialStatePropertyAll(8),
                                                  backgroundColor:
                                                      const MaterialStatePropertyAll(
                                                          Color.fromARGB(233,
                                                              135, 133, 133)),
                                                  shape: MaterialStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          side:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black))),
                                                  // minimumSize:MaterialStatePropertyAll(Size(10,10))
                                                ),
                                                onPressed: () {
                                                  if (data.storeType ==
                                                      "Ration") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RationDetailAddingPage(
                                                                  storeId: data
                                                                      .storeId,
                                                                )));
                                                  } else if (data.storeType ==
                                                      "Maveli") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                mavelistocks(
                                                                  storeId: data
                                                                      .storeId,
                                                                )));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                supplycostocks(
                                                                  storeID: data
                                                                      .storeId,
                                                                )));
                                                  }
                                                },
                                                child: Text(
                                                  "select",
                                                  style:
                                                      GoogleFonts.abyssinicaSil(
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return const SizedBox();
                            }
                          }))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
