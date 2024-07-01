import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/login/menuhome.dart';

class menuappinfo extends StatefulWidget {
  const menuappinfo({super.key});

  @override
  State<menuappinfo> createState() => _menuappinfoState();
}

class _menuappinfoState extends State<menuappinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Color.fromARGB(136, 255, 255, 255),
      leading: IconButton(onPressed: (){
         Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios_sharp)),
     // title: Text('Rev',style: GoogleFonts.abrilFatface(fontSize:30),),
      ),
     body: SingleChildScrollView(
       child: Column(
        children: [
              Container(
                 height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
              colors: [
       
              Color.fromARGB(255, 73, 49, 38),
              Color.fromARGB(255, 244, 119, 2)
            ]),
            ),
            child: Stack(
              children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 250,left: 50),
                   child: Image(image: AssetImage('images/image 29.png'),),
                 ),
               Padding(
          padding: const EdgeInsets.only(top: 100,left: 5,right: 5,bottom: 20),
          child: Container(decoration: BoxDecoration(color: Color.fromARGB(232, 14, 14, 14),borderRadius: BorderRadius.circular(10)),
            height: 700,
            child:SingleChildScrollView(
              child: Column(children: [
                        Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text('App Info',style: GoogleFonts.abrilFatface(fontSize:30,color:Colors.white),),
                        ),
                        Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(height: 130,width: 130,
                child: Container(color: Color.fromARGB(255, 200, 102, 4),
                  child: Image(image: AssetImage('images/image 29.png'))),
              ),
                        ),
                        Padding(
              padding: const EdgeInsets.only(top: 10,left: 4),
              child: Text('    This"StockIt," introduces a revolutionary solution to simplify the search for essential items, be it groceries or medicines, by integrating real-time inventory information from nearby Ration shops, Supplyco outlets, Maveli outlets and Neethi Stores."StockIt" aims to bridge this gap by leveraging modern technology to create an intuitive and user-friendly platform. Users can seamlessly search for products and receive detailed information on their availability, including the nearest Ration shop or Supplyco outlet,Maveli outlets for groceries and the nearest Neethi Store for medicines. This transformative application not only streamlines the shopping experience but also fosters a more informed and efficient approach to acquiring essential items. Through features like realtime updates, location-based searches, and integrated maps, "StockIt" empowers users to make informed decisions, optimize their shopping routines, and ensure timely access to essential supplies.',
               style: GoogleFonts.inknutAntiqua(fontSize:13,color:Colors.white),),
                        ),
              
              ],),
            ),
          ),
        ),
              ],
            ),
              )
       
        ],
       ),
     ),
    );
  }
}