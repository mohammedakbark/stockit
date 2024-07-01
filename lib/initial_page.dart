import 'package:flutter/material.dart';
import 'package:stockit/presentation/modules/admin/adminlogin.dart';
import 'package:stockit/presentation/modules/mavelistore%20module/maveli_login.dart';
import 'package:stockit/presentation/modules/neethi%20store/neethi_login.dart';
import 'package:stockit/presentation/modules/rationstore.dart/ration_login.dart';
import 'package:stockit/presentation/modules/supplycostore.dart/suplyco_login.dart';
import 'package:stockit/presentation/modules/user_module/login/stockit2.dart';
import 'package:stockit/presentation/modules/user_module/login/user_login.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(

        actions: [IconButton(onPressed: (){
          
        }, icon: Icon(Icons.motion_photos_auto_rounded))],),
      body: Container(
       height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/login.png'),fit: BoxFit.cover,)),
        child: Stack(
          children: [ Center(
            child: Container(
             height: 500,width: 500,
               decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/image 29.png'),fit: BoxFit.cover,)),
              child: Column(
                
                children: [
                  SizedBox(height: 60,width: 170,child: Customebutton(pageCustructor:AdminLogin() , title: "Admin")),
                  SizedBox(height: 60,width: 170,child: Customebutton(pageCustructor:UserLogin() , title: "User")),
                  SizedBox(height: 60,width: 170,child: Customebutton(pageCustructor: RationLogin(), title: "Ration")),
                  SizedBox(height: 60,width: 170,child: Customebutton(pageCustructor: MaveliLogin(), title: "Maveli")),
                  SizedBox(height: 60,width: 170,child: Customebutton(pageCustructor:SuplycoLogin() , title: "Supplyco")),
                  SizedBox(height: 60,width: 170,child: Customebutton(pageCustructor:NeethiLogin() , title: "Neethi")),
                ],
              ),
            ),
          ),]
        ),
      ),
    );
  }
}

class Customebutton extends StatelessWidget {
  String title;
dynamic pageCustructor;

  Customebutton({super.key, required this.pageCustructor, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: ElevatedButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>pageCustructor));
      }, child: Text(title)),
    );
  }
}
