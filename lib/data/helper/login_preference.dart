import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/spashscreen.dart';

class LoginPreference {
  static var PREFERENCE_KEY = "UID";
    final db = FirebaseFirestore.instance;


  static setPreference(uid) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.setString(PREFERENCE_KEY, uid);
  }

  static Future<String?> getPreference() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    return prefer.getString(PREFERENCE_KEY);
  }

  static removePreference(context) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.remove(PREFERENCE_KEY);
    Provider.of<DbController>(context,listen: false).storeId="";
    FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SplashScreen()),
            (route) => false));
  }
  /////////////////////////////////////////
 Future<bool> getUserDataForLogin(id,collection)async{
   final snapshot=await db.collection(collection).doc(id).get();
   if(snapshot.exists){
    return true;
   }else{
    return false;
   }
  }

 Future<String> getStoreTypeForLogin(id)async{
    final snapshot=await db.collection("Store").doc(id).get();
if(snapshot.exists){
  return snapshot.data()!["storeType"];
}else{
  return "";
}
    
  }
}
