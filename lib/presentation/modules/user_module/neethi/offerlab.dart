import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/labtest_model.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booking.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi3.dart';
import 'package:stockit/presentation/modules/user_module/neethi/offer.dart';
import 'package:stockit/presentation/modules/user_module/neethi/offermedcine.dart';

class offerlab extends StatefulWidget {
  const offerlab({super.key});

  @override
  State<offerlab> createState() => _offerlabState();
}

class _offerlabState extends State<offerlab> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: DbController().getSelectedStoreAllLapTest( Provider.of<DbController>(context,listen: false).currentStoreid),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        List<LabtestModel>list=snapshot.data!.docs.map((e) => LabtestModel.fromMap(e.data()as Map<String,dynamic>)).toList();
        if(snapshot.hasData){
        return list.isEmpty?Center(child: Text("No Lab Test"),) :ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                  height: 130,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 60),
                        child: Text(
                          list[index].productname,
                          style: GoogleFonts.inknutAntiqua(
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
                          list[index].price,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                              list[index].mrp,
                            style: TextStyle(
                                decorationColor: Colors.grey[400],
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400]),
                          ),
                          const SizedBox(width: 20),
                           Text(
                            '${list[index].offer}%OFF',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 45,
                            width: 73,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromARGB(189, 130, 240, 221))),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingDetaiPage(
                                               type: "Lab Test",
                                                                          productId:list[index].id!,
                                          )),
                                    );
                                  },
                                  child: const Text('Book',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600))),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black),
                      Row(
                        children: [
                          Image.asset(
                            'images/Document.png',
                            scale: 1.5,
                          ),
                          const Text('Reports in 10Hrs',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  size: 20,
                                  color: Colors.amber[600],
                                )),
                          )
                        ],
                      )
                    ],
                  )),
            );
          },
        );
      }else{
        return SizedBox();
      }}
    );
  }
}
