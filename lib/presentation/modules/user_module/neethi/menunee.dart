import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/presentation/common/profile.dart';
import 'package:stockit/presentation/modules/user_module/login/user_login.dart';
import 'package:stockit/presentation/modules/user_module/neethi/appinfo.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neesettings.dart';
import 'package:stockit/presentation/modules/user_module/neethi/notificationee.dart';
import 'package:stockit/presentation/modules/user_module/neethi/nprofile.dart';
import 'package:stockit/presentation/modules/user_module/neethi/ordernee.dart';
import 'package:stockit/presentation/modules/user_module/neethi/reivewNee.dart';

class menuneethi extends StatefulWidget {
  const menuneethi({super.key});

  @override
  State<menuneethi> createState() => _menuneethiState();
}

class _menuneethiState extends State<menuneethi> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String id = _auth.currentUser!.uid;
    return Drawer(
        backgroundColor: Colors.black,
        child: StreamBuilder(
            stream: _firestore.collection('firebase').doc(id).snapshots(),
            builder: (context, snapshot) {
              
              if(snapshot.connectionState == ConnectionState.waiting){
    return Center(child: CircularProgressIndicator(),);

   }

              DocumentSnapshot data = snapshot.data!;
              return 
                   ListView(
                    children: [
                       Padding(
                        padding: EdgeInsets.only(right: 200, top: 20),
                        child:  CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:data["image"]==""? AssetImage('images/circleavathar.png')as ImageProvider:NetworkImage(data["image"]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 50),
                        child: Text(
                          '${data['name']}',
                          style: GoogleFonts.abrilFatface(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => nprofilr(),
                              ));
                        },
                        leading: Image.asset(
                          'images/User.png',
                          scale: 1,
                        ),
                        title: Text('Profile',
                            style: GoogleFonts.abhayaLibre(
                                fontSize: 15, color: Colors.white)),
                      ),
                     
                      Divider(),
                     
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => appinfoneethi(),
                              ));
                        },
                        leading: Image.asset(
                          'images/appinfo.png',
                          scale: 1,
                        ),
                        title: Text('AppInfo',
                            style: GoogleFonts.abhayaLibre(
                                fontSize: 15, color: Colors.white)),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => orderneethi(),
                              ));
                        },
                        leading: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(color: Colors.black),
                          child: Image(
                            image: AssetImage('images/orderbasket.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text('Orders',
                            style: GoogleFonts.abhayaLibre(
                                fontSize: 15, color: Colors.white)),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => notificationnee(),
                              ));
                        },
                        leading: Image.asset(
                          'images/Notification.png',
                          scale: 1.3,
                        ),
                        title: Text('Notification',
                            style: GoogleFonts.abhayaLibre(
                                fontSize: 15, color: Colors.white)),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          _auth.signOut().then((value) => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => UserLogin())));
                          preferences.clear();
                          log('Logout sucessfully' as num);
                        },
                        leading: Image.asset(
                          'images/logout.png',
                          scale: 1,
                        ),
                        title: Text('Logout',
                            style: GoogleFonts.abhayaLibre(
                                fontSize: 15, color: Colors.white)),
                      ),
                      Divider(),
                    ],
                  );
                }
              )
            );
  }
}
