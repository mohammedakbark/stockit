import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/notificationFromNethioOrder.dart';

class prescriptionorder extends StatefulWidget {
  const prescriptionorder({super.key});

  @override
  State<prescriptionorder> createState() => _prescriptionorderState();
}

class _prescriptionorderState extends State<prescriptionorder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width, //color: Colors.black,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
        child: StreamBuilder<QuerySnapshot>(
            stream: DbController().fetchAllPrescrion(Provider.of<DbController>(context,listen: false).storeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<Map<String, dynamic>> data = snapshot.data!.docs
                  .map((e) => e.data() as Map<String, dynamic>)
                  .toList();
              if (snapshot.hasData) {
                return data.isEmpty
                    ? Center(
                        child: Text("No Prescriptions"),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: Container(
                              height: 450,
                              width: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          data[index]["prescription"]),
                                      fit: BoxFit.cover),
                                  color:
                                      const Color.fromARGB(255, 244, 243, 243),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 370, left: 100),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xff57C1AE))),
                                        onPressed: () {
                                          DbController()
                                              .deletePrescription(
                                                  data[index]["id"])
                                              .then((value) {
                                            DbController()
                                                .sendNotificationToUserbookingStatusOFUser(
                                                    data[index]["uid"],
                                                    NotificationModelForNethiOrder(
                                                        from: Provider.of<
                                                                    DbController>(
                                                                context,
                                                                listen: false)
                                                            .storeId!,
                                                        toID: data[index]
                                                            ["uid"],
                                                        message:
                                                            "'Your prescription Medicines are  available,Visit our store'"));
                                          });
                                        },
                                        child: Text(
                                          'Conform',
                                          style: GoogleFonts.abyssinicaSil(
                                              fontSize: 15,
                                              color: Colors.white),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xff57C1AE))),
                                        onPressed: () {
                                            DbController()
                                                .sendNotificationToUserbookingStatusOFUser(
                                                    data[index]["uid"],
                                                    NotificationModelForNethiOrder(
                                                        from: Provider.of<
                                                                    DbController>(
                                                                context,
                                                                listen: false)
                                                            .storeId!,
                                                        toID: data[index]
                                                            ["uid"],
                                                        message:
                                                            "'Your prescription Medicines are Not available at the time,'")).then((value){
                                                              DbController()
                                              .deletePrescription(
                                                  data[index]["id"]);
                                                            });
                                           
                                             
                                        },
                                        child: Text(
                                          'Cancell',
                                          style: GoogleFonts.abyssinicaSil(
                                              fontSize: 15,
                                              color: Colors.redAccent),
                                        )),
                                  ],
                                ),
                              ),
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
