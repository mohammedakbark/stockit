import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class resetpass extends StatefulWidget {
  const resetpass({super.key});

  @override
  State<resetpass> createState() => _resetpassState();
}

class _resetpassState extends State<resetpass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:AppBar(
        backgroundColor: Color.fromARGB(136, 255, 255, 255),
             leading: IconButton(onPressed: (){
              Navigator.pop(context);
             }, icon: Icon(Icons.arrow_back_ios_new_sharp,size: 35,)),

      ) ,
      body: Container(
        height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/image 5.png'),fit: BoxFit.cover,)),
            child: Padding(
              padding: const EdgeInsets.only(top: 60,bottom: 20,left: 5,right: 5),
              child: Container(
                color: Color.fromARGB(232, 14, 14, 14),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Text('Reset Password',style:GoogleFonts.abrilFatface(fontSize:30,color:Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        height: 60,
                        width: 400,
                        child: TextField(cursorColor: Colors.black,decoration: InputDecoration(hintText: ('Current password'),fillColor: Color.fromARGB(136, 255, 255, 255),filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 60,
                        width: 400,
                        child: TextField(cursorColor: Colors.black,decoration: InputDecoration(hintText: ('New password'),fillColor: Color.fromARGB(136, 255, 255, 255),filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height:60,
                        width: 400,
                        child: TextField(cursorColor: Colors.black,decoration: InputDecoration(hintText: ('Confirm password'),fillColor: Color.fromARGB(136, 255, 255, 255),filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
                      ),
                    ),
                     Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 221, 115, 22)),foregroundColor: MaterialStatePropertyAll(Colors.black)),onPressed: (){}, child: Text('SUBMIT')),
                  )
                ],),
      ),
            )
            )

    );
  }
}