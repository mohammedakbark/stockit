
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     extendBodyBehindAppBar: true,
     appBar: AppBar( backgroundColor: Color.fromARGB(103, 255, 255, 255),toolbarHeight: 50,
    leading: const Icon(Icons.arrow_back_ios,size:35,),
    actions: [
    IconButton(onPressed: (){}, icon: Icon(Icons.menu,size: 35,))
    ],
    ),
     body:  Column(children: [
       Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/image 5.png'),fit: BoxFit.cover)),
       )
     ],),

    );
  }
}