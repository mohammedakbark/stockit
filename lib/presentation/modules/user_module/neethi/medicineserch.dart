import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/medicine_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booking.dart';
import 'package:stockit/presentation/modules/user_module/neethi/medicine.dart';
import 'package:stockit/presentation/modules/user_module/neethi/orderprdct.dart';

class medicinserch extends StatefulWidget {
  const medicinserch({super.key});

  @override
  State<medicinserch> createState() => _medicinserchState();
}

class _medicinserchState extends State<medicinserch> {
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
          'Medicines',
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
          child: Consumer<DbController>(builder: (context, controler, child) {
            return Column(
              children: [
                //SizedBox(height: 90,width: 50,),
                Padding(
                  padding:  const EdgeInsets.only(top: 100),
                  child: SizedBox(
                    height: 60,
                    width: 375,
                    child: TextFormField(
                      onTap: () {
                        controler.getAllMedicineOFSellectedNeethiForSearch( Provider.of<DbController>(context,listen: false).currentStoreid);
                      },
                      onChanged: (value) {
                        controler.sarchmedince(value);
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
                          hintText: ('Search for Medicines')),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 580,
                  width: 375,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(186, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Column(
                    children: [
                      Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: DbController()
                                  .getAllMedicineOFSellectedNeethi(
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

                                if (!snapshot.hasData) {
                                  return const SizedBox();
                                }
                                List<MedicineModel> list = [];
                                if (controler
                                    .listofMEdiceForSearch.isNotEmpty) {
                                  list = controler.resultOfMedicn;
                                } else {
                                  list = snapshot.data!.docs
                                      .map((e) => MedicineModel.fromJson(
                                          e.data() as Map<String, dynamic>))
                                      .toList();
                                }

                                return  list.isEmpty?const Center(child: Text("No medicines"),): ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(image: NetworkImage(list[index].imageUrl)),
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 5),
                                                    child: Column(
                                                      crossAxisAlignment:CrossAxisAlignment.start ,
                                                      children: [
                                                        Text(
                                                          list[index].medName,
                                                          style: GoogleFonts
                                                              .abrilFatface(
                                                                  fontSize: 15),
                                                        ),
                                                          Text(
                                                          list[index].description,
                                                          style: GoogleFonts
                                                              .abrilFatface(
                                                                  fontSize: 12),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .currency_rupee,
                                                              size: 14,
                                                            ),
                                                            Text(
                                                              list[index].price.toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .currency_rupee,
                                                              size: 13,
                                                              color: Colors
                                                                  .grey[400],
                                                            ),
                                                            Text(
                                                              list[index].mrp.toString(),
                                                              style: TextStyle(
                                                                  decorationColor:
                                                                      Colors.grey[
                                                                          400],
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey[400]),
                                                            ),
                                                            const SizedBox(width: 20),
                                                            Text(
                                                              '${list[index].offer.toString()}%OFF',
                                                              style: const TextStyle(
                                                                  color:
                                                                      Colors.red,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                               BookingDetaiPage(productId: list[index].medId!,type: "Medicine ",)));
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 20,
                                                )),
                                          ],
                                        ),
                                        const Divider(color: Colors.black)
                                      ],
                                    );
                                  },
                                );
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
