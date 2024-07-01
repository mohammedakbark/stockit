import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/login_preference.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/initial_page.dart';
import 'package:stockit/presentation/modules/admin/adminhome.dart';
import 'package:stockit/presentation/modules/mavelistore%20module/packagemaveli.dart';
import 'package:stockit/presentation/modules/neethi%20store/packageneemodule.dart';
import 'package:stockit/presentation/modules/rationstore.dart/packageration.dart';
import 'package:stockit/presentation/modules/supplycostore.dart/packagesupplyco.dart';
import 'package:stockit/presentation/modules/user_module/home/home1.dart';
import 'package:stockit/presentation/modules/user_module/login/user_login.dart';
import 'package:stockit/presentation/modules/user_module/login/stockit2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      // final currentUser = FirebaseAuth.instance.currentUser;

      // if (currentUser != null) {
      final loginData = await LoginPreference.getPreference();
      if ( loginData == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => UserLogin()),
            (route) => false);
      } else if (loginData == Services.ADMIN_UID) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const adminhome()),
            (route) => false);
      } else {
        final boolValue =
            await LoginPreference().getUserDataForLogin(loginData, "firebase");
        if (boolValue == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => home1()),
              (route) => false);
        } else {
          final type = await LoginPreference().getStoreTypeForLogin(loginData);
      final obj=     Provider.of<DbController>(context,listen: false);
    obj     .getCurrentStoreData(loginData);
    log(obj.storeId.toString());

          switch (type) {
            case "Ration":
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => packageration(
                              indexnum: 0,
                            )),
                    (route) => false);
              }
            case "Maveli":
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => packagemaveli(indexnum: 0)),
                    (route) => false);
              }
            case "Neethi":
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => packageneemodule(indexnum: 0)),
                    (route) => false);
              }
            case "Supplyco":
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => pacakagesupplyco(indexnum: 0)),
                    (route) => false);
              }
          }
        }
      }
    });
    // {}
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: //Center(child: Image.asset("images/image 29.png"),),
          Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 241, 196, 176),
                Color.fromARGB(255, 244, 119, 2)
              ]),
        ),
        child: const Image(
          image: AssetImage('images/image 29.png'),
        ),
      ),
      // backgroundColor: const Color.fromRGBO(83, 36, 2,1),
    );
  }
}
