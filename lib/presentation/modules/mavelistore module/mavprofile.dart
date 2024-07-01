import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';

class maveliprofile extends StatefulWidget {
  const maveliprofile({super.key});

  @override
  State<maveliprofile> createState() => _maveliprofileState();
}

class _maveliprofileState extends State<maveliprofile> {
  @override
  Widget build(BuildContext context) {
       final storeProfile= Provider.of<DbController>(context,listen: false).storeModel;

    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
         // backgroundColor: Color.fromARGB(136, 255, 255, 255),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios_sharp)),
           title: Text(
            'Profile',
            style: GoogleFonts.abrilFatface(fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Container(height: 733,width: 400,
          //      height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
           decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
           end: Alignment.bottomCenter,
          colors: [
        
          Color.fromARGB(255, 73, 49, 38),
          Color.fromARGB(255, 244, 119, 2)
        ]),
              
                ),
                child: Stack(children: [Padding(
                padding: const EdgeInsets.only(top: 250,left: 50),
                child: Image(image: AssetImage('images/image 29.png'),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:50,left:5,right: 5,bottom: 20),
                child: Column(
        children: [
         SizedBox(height: 60,),
          Container(
            height:600,width: 400,
            color: Color.fromARGB(170, 0, 0, 0),
            child: Column(
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Stack(
                    children: [Container( height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(storeProfile!.imageUrl)),
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        
                                        ),),
                                       
                                        ] 
                  ),
                ),

                                  
                                    Text(storeProfile!.name,style: GoogleFonts.abrilFatface(
                      fontSize: 20, color: Colors.white)),
                       Text('Store Id : ${storeProfile.storeId}',style: GoogleFonts.abrilFatface(
                      fontSize: 20, color: Colors.white)),
                                    Text('${storeProfile.branch},Pin:${storeProfile.pin}\nPh:${storeProfile.phoneNumber}',style: GoogleFonts.abrilFatface(
                      fontSize: 20, color: Colors.white)),
              ],
            ),
          ),
        ],
                ),
              )
              ],),
            )
          ],
        ),
    );
  }
}