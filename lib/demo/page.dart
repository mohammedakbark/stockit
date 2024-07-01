
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stockit/demo/demo.dart';
import 'package:stockit/demo/firstpage.dart';

class mypage extends StatelessWidget {
  const mypage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){Navigator.push(context,
             MaterialPageRoute(builder:(context)=>const MyWidget()),);}, child: const Text("Open")),
         const Row(
          children: [
            Text('welcome'),
          Text('to ooty'),
          Text('nice to'),
          Text('meet you')
          ],

         )
          ],
        ),
      ) 
    );
      
      
      
  }
  }