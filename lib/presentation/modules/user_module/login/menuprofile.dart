import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:stockit/presentation/modules/user_module/login/menuhome.dart';

class menuprofile extends StatefulWidget {
  const menuprofile({super.key});

  @override
  State<menuprofile> createState() => _menusprofileState();
}


class _menusprofileState extends State<menuprofile> {
  File? selectedImage;
  final _firestore=FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;
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
      Column(
        children: [
          StreamBuilder(stream: _firestore.collection('firebase').doc(id).snapshots(),
           builder: (context, snapshot) {
            DocumentSnapshot data=snapshot.data!;
             return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(image: DecorationImage(image: AssetImage(''),fit: BoxFit.cover)),
             decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
            colors: [

            Color.fromARGB(255, 73, 49, 38),
            Color.fromARGB(255, 244, 119, 2)
          ]),
      
        ),
      child:Stack(children: [Padding(
        padding: const EdgeInsets.only(top: 250,left: 50),
        child: Image(image: AssetImage('images/image 29.png'),),
      ),
       Padding(
              padding: const EdgeInsets.only(top: 100,left:5,right: 5,bottom: 20),
              child: Container(
                height: 700,width: 400,
                color: Color.fromARGB(170, 0, 0, 0),
              child:Column(children: [Padding(
                padding: const EdgeInsets.only(top: 50),
              
                child: Container(height:150 ,width: 150,decoration: BoxDecoration(image: DecorationImage(fit:BoxFit.cover,image: selectedImage !=null?
                FileImage(selectedImage!) :AssetImage('') as ImageProvider<Object>),
                shape: BoxShape.circle,color: Colors.white,),
                  padding: const EdgeInsets.only(top: 80,left: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Container(height: 20,width: 20,decoration: BoxDecoration(shape: BoxShape.circle,color: Color.fromARGB(149, 255, 255, 255)),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(onPressed: ()async{
                        await  _pickedImageGallery().then((value) async {
                                                {
                                                  SettableMetadata metadata =
                                                      SettableMetadata(
                                                    contentType: 'image/jpeg',
                                                  );
                                                  final currenttime =
                                                      TimeOfDay.now();
                                                  UploadTask uploadTask =
                                                      FirebaseStorage.instance
                                                          .ref()
                                                          .child(
                                                            'profileimage/profile$currenttime',
                                                          )
                                                          .putFile(
                                                              selectedImage!,
                                                              metadata);
                                                  TaskSnapshot snapshot =
                                                      await uploadTask;
                                                  await snapshot.ref
                                                      .getDownloadURL()
                                                      .then((url) {
                                                    String id =
                                                        randomString(10);
                                                    FirebaseFirestore.instance
                                                        .collection('image')
                                                        .doc(id)
                                                        .update({'image':url});
                                                  });
                                                }
                                              });
                        },icon:Icon(Icons.camera_alt_outlined,color: Colors.black,size: 30,)),
                      ),
                    ),
                  ),
                
                ),
              ),
              Text('${data['name']}',style: GoogleFonts.abrilFatface(fontSize:30,color:Colors.white)),
              Text('${data['address']}',style: GoogleFonts.abhayaLibre(fontSize:23,color:Colors.white)),
              Text('${data['email']}',style: GoogleFonts.abhayaLibre(fontSize:23,color:Colors.white)),
              
              ],) ,
              ),)
       ],),
    
            // child: 
              
              
            // ),
          );
          },)
         ,
        ],
      ),
    );
  }
}