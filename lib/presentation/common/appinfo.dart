import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appinfo extends StatefulWidget {
  const appinfo({super.key});

  @override
  State<appinfo> createState() => _appinfoState();
}

class _appinfoState extends State<appinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true,
       appBar: AppBar(backgroundColor: Color.fromARGB(136, 255, 255, 255),
       leading: IconButton(onPressed: (){
        Navigator.pop(context);
       }, icon:Icon(Icons.arrow_back_ios_sharp)),),
       body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/image 5.png'),fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(top: 100,left: 5,right: 5,bottom: 20),
          child: Container(
            color: Color.fromARGB(232, 14, 14, 14),
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text('App Info',style: GoogleFonts.abrilFatface(fontSize:30,color:Colors.white),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(height: 150,width: 150,
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

    );
  }
}