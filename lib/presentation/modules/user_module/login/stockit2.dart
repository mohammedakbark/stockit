// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stockit/presentation/modules/user_module/login/logpag.dart';
// //import 'package:stockit/login/stock3.dart';
// import 'package:stockit/presentation/modules/user_module/login/stockit3.dart';

// class stockit2 extends StatelessWidget {
//   const stockit2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/login.png'),fit: BoxFit.cover)),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 550.0),
//             child: Column(children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   width: 280,
//                   height: 50,
//                   child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                   onPressed:() {
//                     Navigator.push(context,
//              MaterialPageRoute(builder:(context)=> logipage()),);
//                   }, child: Text('Login',style:GoogleFonts.inknutAntiqua(fontSize:20,color:Colors.white),))),
//               ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                   width: 280,
//                   height: 50,
//                   child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                   onPressed:() {}, child: Text('Sign up',style:GoogleFonts.inknutAntiqua(fontSize:20,color:Colors.white),))),
//                 ),
//             ],
            
//             ),
//           ),
      
//         ),
//       ),
//     );
//   }
// }