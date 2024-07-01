import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/notificationFromNethioOrder.dart';
import 'package:stockit/presentation/modules/user_module/neethi/menunee.dart';

class notificationnee extends StatefulWidget {
  const notificationnee({super.key});

  @override
  State<notificationnee> createState() => _notificationneeState();
}

class _notificationneeState extends State<notificationnee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
            )),
        title: Text(
          'Notification',
          style: GoogleFonts.abrilFatface(fontSize: 30),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, left: 5, right: 5, bottom: 20),
          child: Container(
              color: const Color.fromARGB(214, 0, 0, 0),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: DbController().fetchMyNethiNotifcaition(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            List<NotificationModelForNethiOrder> notifcia =
                                snapshot
                                    .data!.docs
                                    .map((e) =>
                                        NotificationModelForNethiOrder.fromjson(
                                            e.data() as Map<String, dynamic>))
                                    .toList();
                            if (snapshot.hasData) {
                              return notifcia.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No notifcation",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: notifcia.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 30, right: 30),
                                          child: Container(
                                            height: 100,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.white)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 255),
                                                  child: Image.asset(
                                                    'images/hai.png',
                                                    scale: 1.8,
                                                  ),
                                                ),
                                                //Icon(Icons.notifications_active,color: Colors.yellow[800],),
                                                Text(
                                                  notifcia[index].message,
                                                  // 'Your order cancelled,Please order again.',
                                                  style:
                                                      GoogleFonts.abyssinicaSil(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                ),
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
              )),
        ),
      ),
    );
  }
}
