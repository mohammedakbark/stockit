// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stockit/presentation/modules/user_module/user%20supplyco/supplyco_stock_view.dart';

// class details extends StatefulWidget {
//   String storeId;
//   const details({super.key});

//   @override
//   State<details> createState() => _detailsState();
// }

// class _detailsState extends State<details> {
//   @override
//   Widget build(BuildContext context) {
//     // ignore: prefer_const_constructors
//     return Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//            leading: IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_back_ios_sharp) ),
//         title: Text('Supplyco Store',style: GoogleFonts.inknutAntiqua(fontSize:25),),backgroundColor: const Color.fromARGB(136, 255, 255, 255),
//         ),
//        body: SingleChildScrollView(
//         child: Column(children: [
//                Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(image:DecorationImage(image: AssetImage('images/image 5.png'),fit: BoxFit.cover) ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 80,left: 40,right: 40,bottom: 40),
//                   child: Container(
//                     color:  const Color.fromARGB(135, 255, 255, 255),
//                     child:  Column(children: [
//                        Padding(
//                          padding: const EdgeInsets.only(top: 30),
//                          child: Text('Your Details',style: GoogleFonts.abrilFatface(fontSize:40,color:Colors.black),),
//                        ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 30),
//                           child: SizedBox(
//                             height: 50,
//                             width: 350,
//                             child: TextField(cursorColor: Colors.black,
//                             decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black)),
//                             fillColor: Color.fromARGB(177, 255, 255, 255),filled: true,hintText: ('Enter your Name')),
//                          ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 15),
//                           child: SizedBox(
//                             height: 50,
//                             width: 350,
//                             child: TextField(inputFormatters: [LengthLimitingTextInputFormatter(16)],keyboardType: TextInputType.number,cursorColor: Colors.black,
//                             decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black)),
//                             fillColor: Color.fromARGB(177, 255, 255, 255),filled: true,hintText: ('Card number')),
//                          ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 15),
//                           child: SizedBox(
//                             height: 50,
//                             width: 350,
//                             child: TextField(inputFormatters: [ LengthLimitingTextInputFormatter(20),
//                                    FilteringTextInputFormatter.digitsOnly],keyboardType: TextInputType.number,cursorColor: Colors.black,
//                             decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black)),
//                             fillColor: Color.fromARGB(177, 255, 255, 255),filled: true,hintText: ('Phone Number')),
//                          ),
//                           ),
//                         ),
//                          Padding(
//                     padding: const EdgeInsets.only(top: 40),
//                     child: SizedBox( height: 50,width: 130,
//                       child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),foregroundColor: MaterialStatePropertyAll(Colors.white)),
//                       onPressed: (){
//                         Navigator.push(context,
//               MaterialPageRoute(builder:(context)=> SupplycoStockView()),);
//                       }, child: Text('Submit',style: TextStyle(fontSize: 18),)),
//                     ),
//                   )
                 

//                     ],),
//                   ),
//                 ),
//                )

//         ],),
//        ),
//     );
//   }
// }