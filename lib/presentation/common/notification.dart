import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/notification_model.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(136, 255, 255, 255),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp)),
        title: Text(
          'Notification',
          style: GoogleFonts.abrilFatface(fontSize: 30),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/image 5.png'), fit: BoxFit.cover)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, left: 5, right: 5, bottom: 20),
          child: Container(
              color: Color.fromARGB(214, 0, 0, 0),
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: DbController().getCurrentUserNotification(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        List<NotificationModel> listOfNotification = [];
                        listOfNotification = snapshot.data!.docs
                            .map((e) => NotificationModel.fromjson(
                                e.data() as Map<String, dynamic>))
                            .toList();
                        if (snapshot.hasData) {
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: listOfNotification.length,
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
                                                width: 1, color: Colors.white)),
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 280, top: 5),
                                                  child: Icon(
                                                    Icons.notifications_active,
                                                    color: Colors.yellow[800],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, left: 30),
                                                  child: Text(
                                                    'Your order ${listOfNotification[index].message}',
                                                    style: GoogleFonts
                                                        .abyssinicaSil(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }));
                        } else {
                          return SizedBox();
                        }
                      })
                ],
              )),
        ),
      ),
    );
  }
}
