import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/medicine_model.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booking.dart';


class offermedicine extends StatefulWidget {
  const offermedicine({super.key});

  @override
  State<offermedicine> createState() => _offermedicineState();
}

class _offermedicineState extends State<offermedicine> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DbController().getAllMedicines( Provider.of<DbController>(context,listen: false).currentStoreid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<MedicineModel> list = snapshot.data!.docs
              .map((e) =>
                  MedicineModel.fromJson(e.data() as Map<String, dynamic>))
              .toList();
          if (snapshot.hasData) {
            return list.isEmpty?Center(child: Text("No Medicine"),): ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var data=list[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Container(
                      height: 130,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8, left: 5),
                                child: Text(
                                  data.medName,
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 19,
                                ),
                                Text(
                                  data.price.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 15,
                                  color: Colors.grey[400],
                                ),
                                Text(
                                  data.mrp.toString(),
                                  style: TextStyle(
                                      decorationColor: Colors.grey[400],
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400]),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  '${data.offer}%OFF',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 0.3,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromARGB(
                                                    189, 130, 240, 221))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingDetaiPage(
                                                 type: "Medicine",
                                                                          productId:list[index].medId!,
                                            )),
                                      );
                                    },
                                    child: Text('Order',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 125),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 26,
                                      color: Colors.amber[600],
                                    )),
                              )
                            ],
                          ),
                        ],
                      )),
                );
              },
            );
          } else {
            return SizedBox();
          }
        });
  }
}
