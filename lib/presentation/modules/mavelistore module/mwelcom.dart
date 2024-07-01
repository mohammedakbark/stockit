// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:stockit/presentation/modules/mavelistore%20module/mlogin.dart';

// class mwelcom extends StatefulWidget {
//   const mwelcom({super.key});

//   @override
//   State<mwelcom> createState() => _mwelcomState();
// }

// class _mwelcomState extends State<mwelcom> {
//   void initState(){
//     super.initState();
//     Future.delayed(const Duration(seconds:3),(){
//       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>mlogin()));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        body:
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