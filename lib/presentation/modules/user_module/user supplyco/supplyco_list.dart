import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/store_model.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/data/provider/location_provider.dart';
import 'package:stockit/presentation/modules/user_module/user%20supplyco/supplycostocks.dart';

class SupplycoListView extends StatefulWidget {
  const SupplycoListView({super.key});

  @override
  State<SupplycoListView> createState() => _SupplycoListViewState();
}

class _SupplycoListViewState extends State<SupplycoListView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(139, 255, 255, 255),
        toolbarHeight: 50,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text('Supplyco Store',
            style: GoogleFonts.abrilFatface(fontSize: 30)),
      ),
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
              child: Consumer<DbController>(
                builder: (context,searhcer,child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: SizedBox(
                          height: 60,
                          width: 350,
                          child: TextFormField(
                              onTap: () {
                              searhcer.getAllStoreForSearch("Supplyco");
                            },
                            onChanged: (value) {
                              searhcer.searchStore(value);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 35,
                                ),
                                hintText: ('Search location')),
                          ),
                        ),
                      ),
                      Expanded(child: Consumer<LocationService>(
                          builder: (context, services, child) {
                        return StreamBuilder(
                            stream: DbController().getAllStore("Supplyco"),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              List<StoreModel> listOfData = [];
                                if (searhcer.storeForSearch.isNotEmpty) {
                                    listOfData = searhcer.storeSearchResult;
                                  }else{
                                    listOfData = snapshot.data!.docs
                                  .map((e) => StoreModel.fromjson(e.data()))
                                  .toList();
                                    
                                  }
                              
                              listOfData = listOfData
                                  .where((element) =>
                                      element.latitude.toInt() ==
                                          services.locationData!.latitude!.toInt() &&
                                      element.longitude.toInt() ==
                                          services.locationData!.longitude!.toInt())
                                  .toList();
                  
                              if (snapshot.hasData) {
                                return listOfData.isEmpty
                                    ? const Center(
                                        child: Text("No Store"),
                                      )
                                    : ListView.builder(
                                        itemCount: listOfData.length,
                                        itemBuilder: (context, index) {
                                          final data = listOfData[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 20, right: 20),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: width,
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
                                                      'Supplyco Store\n${data.branch}, Pin: ${data.pin}\nPh:${data.phoneNumber}',
                                                      style:
                                                          GoogleFonts.abyssinicaSil(
                                                              fontSize: 15),
                                                    )),
                                                  ),
                                                  Column(
                                                    children: [
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                            //elevation:MaterialStatePropertyAll(8),
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    Color.fromARGB(
                                                                        233,
                                                                        135,
                                                                        133,
                                                                        133)),
                                                            shape: MaterialStatePropertyAll(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                10),
                                                                    side: BorderSide(
                                                                        color: Colors
                                                                            .black))),
                                                            // minimumSize:MaterialStatePropertyAll(Size(10,10))
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        supplycostocks(
                                                                          storeID: data
                                                                              .storeId,
                                                                        )));
                                                          },
                                                          child: Text(
                                                            "select",
                                                            style: GoogleFonts
                                                                .abyssinicaSil(
                                                                    fontSize: 18,
                                                                    color:
                                                                        Colors.black),
                                                          )),
                                                      StreamBuilder<DocumentSnapshot>(
                                                          stream: DbController()
                                                              .checkProductisLikedORNot(
                                                            FirebaseAuth.instance
                                                                .currentUser!.uid,
                                                            data.storeId,
                                                          ),
                                                          builder:
                                                              (context, snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const SizedBox();
                                                            }
                                                            //  final snap=;
                                                            if (snapshot.hasData) {
                                                              return IconButton(
                                                                  onPressed: () {
                                                                    // log(
                  
                                                                    DbController().likeMyProduct(
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid,
                                                                        data.storeId,
                                                                        data);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons.favorite,
                                                                    color: snapshot
                                                                            .data!
                                                                            .exists
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            242,
                                                                            146,
                                                                            37)
                                                                        : const Color
                                                                            .fromARGB(
                                                                            233,
                                                                            135,
                                                                            133,
                                                                            133),
                                                                    size: 25,
                                                                  ));
                                                            } else {
                                                              return const SizedBox();
                                                            }
                                                          })
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                              } else {
                                return SizedBox();
                              }
                            });
                      }))
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
