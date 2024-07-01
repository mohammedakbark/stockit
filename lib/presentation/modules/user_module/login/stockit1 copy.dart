import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockit/presentation/modules/user_module/home/home1.dart';
import 'package:stockit/presentation/modules/user_module/login/user_login.dart';
//import 'package:stockit/presentation/modules/user_module/login/stockit2.dart';

class stockit1 extends StatefulWidget {
  const stockit1({super.key});

  @override
  State<stockit1> createState() => _stockit1State();
}

class _stockit1State extends State<stockit1> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds:3),(){
      Timer(Duration(seconds: 1),()=> check( ));
    });
  }
  check()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? name=preferences.getString('isloggin');

    if(name!=null)
    {
       Navigator.push(context,MaterialPageRoute(builder: (context) =>  home1()) );
    }
    else
    {
      Navigator.push(context,MaterialPageRoute(builder: (context) =>  UserLogin()) );
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body://Center(child: Image.asset("images/image 29.png"),),
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
      child:Image(image: AssetImage('images/image 29.png'),),
      ),
     // backgroundColor: const Color.fromRGBO(83, 36, 2,1),
    );
  }
}