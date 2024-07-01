import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/labtest_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booking.dart';
import 'package:stockit/presentation/modules/user_module/neethi/labtest.dart';
import 'package:stockit/presentation/modules/user_module/neethi/labtest_list_page.dart';

class popularlab extends StatefulWidget {
  const popularlab({super.key});

  @override
  State<popularlab> createState() => _popularlabState();
}

class _popularlabState extends State<popularlab> {
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
          'Lab Test',
          style: GoogleFonts.inknutAntiqua(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
          child: Consumer<DbController>(builder: (context, search, hild) {
            return Column(
              children: [
                //SizedBox(height: 90,width: 50,),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SizedBox(
                    height: 50,
                    width: 325,
                    child: TextFormField(
                      onTap: () {
                        search.getAllLabTestForSearch(
                            Provider.of<DbController>(context, listen: false)
                                .currentStoreid);
                      },
                      onChanged: (value) {
                        search.searchLabtest(value);
                      },
                      cursorColor: Colors.black,
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
                          hintText: ('Search for test and pakages')),
                    ),
                  ),
                ),
                const SizedBox(height: 15, width: 30),
                Container(
                  height: 565,
                  width: 325,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(186, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/Lab.png',
                            scale: 1.2,
                          ),
                          Text(
                            'Popular Tests',
                            style: GoogleFonts.inknutAntiqua(fontSize: 25),
                          )
                        ],
                      ),
                      Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: DbController().getSelectedStoreAllLapTest(
                                  Provider.of<DbController>(context,
                                          listen: false)
                                      .currentStoreid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                List<LabtestModel> listOflabtest = [];
                                
                        if(search.listOFLabTest.isNotEmpty){
                          listOflabtest=search.resultOfLabtestsearch;

                        }else{
                           listOflabtest=       snapshot
                                    .data!.docs
                                    .map((e) => LabtestModel.fromMap(
                                        e.data() as Map<String, dynamic>))
                                    .toList();
                        }

                                if (snapshot.hasData) {
                                  return listOflabtest.isEmpty?Center(child: Text("no test found"),): ListView.builder(
                                    itemCount: listOflabtest.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Container(
                                            // height: 160,
                                            // width: 300,
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
                                                    listOflabtest[index]
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
                                                    listOflabtest[index].price,
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
                                                    listOflabtest[index].mrp,
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
                                                    '${listOflabtest[index].offer}%OFF',
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ]),
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
                                                              builder: (context) =>
                                                                  BookingDetaiPage(
                                                                    type:
                                                                        "Lab Test",
                                                                    productId:
                                                                        listOflabtest[index]
                                                                            .id!,
                                                                  )),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Book',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                ),
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
                                                    // const SizedBox(
                                                    //   width: 120,
                                                    // ),
                                                    // IconButton(
                                                    //     onPressed: () {},
                                                    //     icon: const Icon(
                                                    //       Icons.shopping_cart,
                                                    //       size: 20,
                                                    //     ))
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
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
