// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class rlogin1 extends StatefulWidget {
//   const rlogin1({super.key});

//   @override
//   State<rlogin1> createState() => _rlogin1State();
// }

// class _rlogin1State extends State<rlogin1> {
//    void initState(){
//     super.initState();
//     Future.delayed(const Duration(seconds:3),(){
//       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>rlogin2()));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//              end: Alignment.bottomCenter,
//             colors: [

            
//             Color.fromARGB(255, 241, 196, 176),
//             Color.fromARGB(255, 244, 119, 2)
//           ]),
      
//         ),
//       child:Image(image: AssetImage('images/image 29.png'),),
//       ),
//     );
//   }
// }