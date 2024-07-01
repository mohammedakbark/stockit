import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/feedback_model.dart';

class adminfeedback extends StatefulWidget {
  const adminfeedback({super.key});

  @override
  State<adminfeedback> createState() => _adminfeedbackState();
}

class _adminfeedbackState extends State<adminfeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        title: Text(
          'Feedbacks',
          style: GoogleFonts.abrilFatface(fontSize: 23),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 73, 49, 38),
                Color.fromARGB(255, 244, 119, 2)
              ]),
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: DbController().getAllFeddback(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<FeedbackModel> listOFFeedback = snapshot.data!.docs
                  .map((e) =>
                      FeedbackModel.fromJosn(e.data() as Map<String, dynamic>))
                  .toList();
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: listOFFeedback.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      // height: 245,
                      // width: 250,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                            children: [
                               Text(
                                 listOFFeedback[index].email,
                                 style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.white),
                               ),
                              // Text(
                              //   'Email Id',
                              //   style: TextStyle(
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.white),
                              // ),
                              Container(

                                // height: 150,
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        94, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10)),
                                    child: Text(listOFFeedback[index].suggestions),
                              )
                            ],
                          )
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
