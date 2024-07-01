import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds:3),(){
      //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body:
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
            colors: [

            Color.fromARGB(255, 73, 49, 38),
            Color.fromARGB(255, 244, 119, 2)
          ]),
      
        ),
      child:Image(image: AssetImage('images/image 29.png'),),
      ),
    );
  }
}