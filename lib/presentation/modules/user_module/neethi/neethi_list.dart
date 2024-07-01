import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/store_model.dart';
import 'package:stockit/data/provider/location_provider.dart';
import 'package:stockit/presentation/modules/user_module/home/home1.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi3.dart';
import 'package:stockit/presentation/modules/user_module/package.dart';

class NeethiListView extends StatefulWidget {
  const NeethiListView({super.key});

  @override
  State<NeethiListView> createState() => _NeethiListViewState();
}

class _NeethiListViewState extends State<NeethiListView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(199, 255, 255, 255),
        toolbarHeight: 50,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_sharp,
            )),
        title:
            Text('Neethi Store', style: GoogleFonts.abrilFatface(fontSize: 25)),
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
                      image: AssetImage('images/pharmacy.png'),
                      fit: BoxFit.cover)),
              child:
                  Consumer<DbController>(builder: (context, searcher, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: SizedBox(
                        height: 60,
                        width: 350,
                        child: TextFormField(
                          onTap: () {
                            searcher.getAllStoreForSearch("Neethi");
                          },
                          onChanged: (value) {
                            searcher.searchStore(value);
                          },
                          cursorColor: Colors.black,
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
                          stream: DbController().getAllStore("Neethi"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            List<StoreModel> listOfData = [];
                            if (searcher.storeForSearch.isNotEmpty) {
                              listOfData = searcher.storeSearchResult;
                               listOfData = listOfData
                                  .where((element) =>
                                      element.latitude.toInt() ==
                                          services.locationData!.latitude!
                                              .toInt() &&
                                      element.longitude.toInt() ==
                                          services.locationData!.longitude!
                                              .toInt())
                                  .toList();
                            } else {
                              listOfData = snapshot.data!.docs
                                  .map((e) => StoreModel.fromjson(e.data()))
                                  .toList();
                              listOfData = listOfData
                                  .where((element) =>
                                      element.latitude.toInt() ==
                                          services.locationData!.latitude!
                                              .toInt() &&
                                      element.longitude.toInt() ==
                                          services.locationData!.longitude!
                                              .toInt())
                                  .toList();
                            }

                            if (snapshot.hasData) {
                              return listOfData.isEmpty
                                  ? const Center(
                                      child: Text("No Store"),
                                    )
                                  : ListView.builder(
                                      itemCount: listOfData.length,
                                      itemBuilder: (context, index) {
                                        final data = listOfData[index];
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                width: width,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                          child: Text(
                                                        'Neethi Store\n${data.branch}, Pin: ${data.pin}\nPh:${data.phoneNumber}',
                                                        // 'Neethi store Manjeri,Eranad Thaluk, 676509,Malappuram(Dt),                       Manjeri- Malappuram Rod.',
                                                        style: GoogleFonts
                                                            .abyssinicaSil(
                                                                fontSize: 15),
                                                      )),
                                                    ),
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                          //elevation:MaterialStatePropertyAll(8),
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Color
                                                                      .fromARGB(
                                                                          233,
                                                                          135,
                                                                          133,
                                                                          133)),
                                                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
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
                                                        Provider.of<DbController>(context,listen: false).getStorId(data.storeId);
                                                        // log( Provider.of<DbController>(context,listen: false).currentStoreid.toString());
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          packages(
                                                                            indexnum:
                                                                                0,
                                                                          )));
                                                        },
                                                        child: Text(
                                                          "select",
                                                          style: GoogleFonts
                                                              .abyssinicaSil(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        );
                                      });
                            } else {
                              return SizedBox();
                            }
                          });
                    }))
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
