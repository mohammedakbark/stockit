import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
     appBar: 
     AppBar(backgroundColor: Color.fromARGB(136, 255, 255, 255),
             leading: IconButton(onPressed: (){
              Navigator.pop(context);
             }, icon: Icon(Icons.arrow_back_ios_new_sharp)),
             ),
    body: Container(
         height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/image 5.png'),fit: BoxFit.cover,)),
            child: Padding(
              padding: const EdgeInsets.only(top: 100,bottom: 20,left: 5,right: 5),
              child: Container(
                color: Color.fromARGB(232, 14, 14, 14),
                child: Column(children: [
                  ListTile(
                    leading: Icon(Icons.settings,size: 40,color: Color.fromARGB(255, 239, 164, 3),),
                    title: Text('Settings',style: GoogleFonts.abrilFatface(fontSize:25,color:Colors.white),),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(right: 230),
                    child: Text('Language',style: GoogleFonts.abhayaLibre(fontSize:25,color:Colors.white)),
                  ),
                 Divider(
                    color: Colors.white,
                  ),
                    Padding(
                      padding: const EdgeInsets.only(right: 180),
                      child: Text('Reset Password',style: GoogleFonts.abhayaLibre(fontSize:25,color:Colors.white)),
                    ),
                 Divider(
                    color: Colors.white,
                  ),
                   Padding(
                     padding: const EdgeInsets.only(right: 180),
                     child: Text('Delete Account',style: GoogleFonts.abhayaLibre(fontSize:25,color:Colors.white)),
                   ),
               
                ],),
              ),
            ),
    ),        
    );
  }
}