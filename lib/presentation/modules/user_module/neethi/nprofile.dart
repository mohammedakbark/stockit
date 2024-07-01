import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockit/presentation/modules/user_module/login/menuprofile.dart';
import 'package:stockit/presentation/modules/user_module/neethi/menunee.dart';

class nprofilr extends StatefulWidget {
  const nprofilr({super.key});

  @override
  State<nprofilr> createState() => _nprofilrState();
}

class _nprofilrState extends State<nprofilr> {
  final _firestore=FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
      Future<void>_pickedImageGallery()async{
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedImage == null)return;
      setState(() {
        selectedImage=File(pickedImage.path);
      });
    }
    
    String id=_auth.currentUser!.uid;
    return Scaffold(
       extendBodyBehindAppBar: true,
       
      appBar: AppBar(backgroundColor: Color.fromARGB(136, 255, 255, 255),
      leading: IconButton(onPressed: (){
         Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios_sharp)),
      title: Text('Profile',style: GoogleFonts.abrilFatface(fontSize:30),),),
      body: 
      SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(stream: _firestore.collection('firebase').doc(id).snapshots(),
             builder: (context, snapshot) {
              DocumentSnapshot data=snapshot.data!;
               return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/pharmacy.png'),fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.only(top: 100,left:5,right: 5,bottom: 20),
                child: Container(color: Color.fromARGB(170, 0, 0, 0),
                child:Column(children: [Padding(
                  padding: const EdgeInsets.only(top: 50),
                
                  child: Container(height:150 ,width: 150,decoration: BoxDecoration(image: DecorationImage(fit:BoxFit.cover,image: selectedImage !=null?
                  FileImage(selectedImage!) :AssetImage('') as ImageProvider<Object>),
                  shape: BoxShape.circle,color: Colors.white,),
                    padding: const EdgeInsets.only(top: 80,left: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100),
                      
                    ),
                  
                  ),
                ),
                Text('${data['name']}',style: GoogleFonts.abrilFatface(fontSize:30,color:Colors.white)),
                Text('${data['address']}',style: GoogleFonts.abhayaLibre(fontSize:23,color:Colors.white)),
                Text('${data['email']}',style: GoogleFonts.abhayaLibre(fontSize:23,color:Colors.white)),
                
                ],)
                ),
                
                
              ),
            );
            },)
           ,
          ],
        ),
      ),

    );
  }
}