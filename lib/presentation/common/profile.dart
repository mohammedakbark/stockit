import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/modules/user_module/login/menuprofile.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  File? selectedImage;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // Future<void> _pickedImageGallery() async {
    //   final pickedImage =
    //       await ImagePicker().pickImage(source: ImageSource.gallery);
    //   if (pickedImage == null) return;
    //   setState(() {
    //     selectedImage = File(pickedImage.path);
    //   });
    // }

    String id = _auth.currentUser!.uid;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 255, 255, 255),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_sharp)),
          title: Text(
            'Profile',
            style: GoogleFonts.abrilFatface(fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: _firestore.collection('firebase').doc(id).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  DocumentSnapshot data = snapshot.data!;
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/image 5.png'),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 100, left: 5, right: 5),
                      child: Container(
                          height: 400,
                          width: 450,
                          color: const Color.fromARGB(170, 0, 0, 0),
                          child: Column(
                            children: [
                              Consumer<Controller>(
                                  builder: (context, controller, child) {

                 return InkWell(
                                  onTap: () {
                                    controller
                                        .pickeImageFromGallery()
                                        .then((value) async {
                                        log(controller.fileImage.toString());
                                       controller
                                          .storeImage(controller.fileImage!,
                                              "userprofileimage")
                                          .then((url) {
                                            // log(url??"NA");
                                        FirebaseFirestore.instance
                                            .collection("firebase")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({"image": url});
                                      });
                                    });
                                  },
                                  child: data['image'] == ""
                                      ? const CircleAvatar(
                                         
                                          radius: 80,
                                           child: Icon(Icons.add_a_photo),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50),
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    NetworkImage(data['image']!),
                                              ),
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 80, left: 10),
                                          ),
                                        ),
                                );
                              }),
                              Text('${data['name']}',
                                  style: GoogleFonts.abrilFatface(
                                      fontSize: 30, color: Colors.white)),
                              Text('${data['address']}',
                                  style: GoogleFonts.abhayaLibre(
                                      fontSize: 23, color: Colors.white)),
                              Text('${data['email']}',
                                  style: GoogleFonts.abhayaLibre(
                                      fontSize: 23, color: Colors.white)),
                            ],
                          )),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
