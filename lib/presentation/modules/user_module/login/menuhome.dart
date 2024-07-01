import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockit/data/helper/login_preference.dart';
import 'package:stockit/presentation/common/profile.dart';
import 'package:stockit/presentation/modules/user_module/login/user_login.dart';
import 'package:stockit/presentation/modules/user_module/login/menuappinfo.dart';
import 'package:stockit/presentation/modules/user_module/login/menuprofile.dart';
import 'package:stockit/presentation/modules/user_module/login/menureview.dart';
import 'package:stockit/presentation/modules/user_module/login/menusettings.dart';
import 'package:stockit/presentation/modules/user_module/neethi/appinfo.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neesettings.dart';
import 'package:stockit/presentation/modules/user_module/neethi/nprofile.dart';
import 'package:stockit/presentation/modules/user_module/neethi/reivewNee.dart';

class menuhome extends StatefulWidget {
  const menuhome({super.key});

  @override
  State<menuhome> createState() => _menuhomeState();
}

class _menuhomeState extends State<menuhome> {
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
              return ListView(
                children: [
                   Padding(
                    padding: EdgeInsets.only(right: 180, top: 20),
                    child:  CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage:data["image"]=="" ?AssetImage('images/circleavathar.png') as ImageProvider:NetworkImage(data["image"]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30),
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
                            builder: (context) => profile(),
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
                            builder: (context) => menureview(),
                          ));
                    },
                    leading: Image.asset(
                      'images/review.png',
                      scale: 1,
                    ),
                    title: Text('Review/Feedback',
                        style: GoogleFonts.abhayaLibre(
                            fontSize: 15, color: Colors.white)),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => menusetting(),
                          ));
                    },
                    leading: Image.asset(
                      'images/Settings.png',
                      scale: 1,
                    ),
                    title: Text('Settings',
                        style: GoogleFonts.abhayaLibre(
                            fontSize: 15, color: Colors.white)),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => menuappinfo(),
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
                    onTap: () async {
                   LoginPreference.removePreference(context);
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
            }));
    
  }
}