import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/login/menuhome.dart';

class menusetting extends StatefulWidget {
  const menusetting({super.key});

  @override
  State<menusetting> createState() => _menusettingState();
}

class _menusettingState extends State<menusetting> {
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
              padding: const EdgeInsets.only(top: 100,bottom: 20,left: 5,right: 5),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(232, 14, 14, 14),),
                
                child: Column(children: [
                  ListTile(
                    leading: Icon(Icons.settings,size: 40,color: Color.fromARGB(255, 239, 164, 3),),
                    title: Text('Settings',style: GoogleFonts.abrilFatface(fontSize:25,color:Colors.white),),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(right: 230),
                    child: Text('Language',style: GoogleFonts.abhayaLibre(fontSize:25,color:Colors.white)),
                  ),
                 Divider(
                    color: Colors.grey,
                  ),
                    Padding(
                      padding: const EdgeInsets.only(right: 180),
                      child: Text('Reset Password',style: GoogleFonts.abhayaLibre(fontSize:25,color:Colors.white)),
                    ),
                 Divider(
                    color: Colors.grey
                  ),
                   Padding(
                     padding: const EdgeInsets.only(right: 180),
                     child: Text('Delete Account',style: GoogleFonts.abhayaLibre(fontSize:25,color:Colors.white)),
                   ),
               
                ],),
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