import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class reset extends StatefulWidget {
  const reset({super.key});

  @override
  State<reset> createState() => _resetState();
}

class _resetState extends State<reset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(child: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/login.png'),fit: BoxFit.cover)),
        child: Column(
          children: [
          
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text('Reset Your Password',style: GoogleFonts.abrilFatface(fontSize:25),)
            ),

            Image(image: AssetImage('images/images 1.png') ),
          
            SizedBox(
              height:50 ,
              width: 350,
              child: TextField(obscureText: true,
                decoration: InputDecoration(fillColor: Color.fromARGB(168, 255,255, 255),filled: true,
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black)),
                hintText: ('New password'),prefixIcon:Icon(Icons.lock),suffixIcon: Icon(Icons.visibility_off) ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height:50 ,
                width: 350,
                child: TextField(obscureText: true,
                  decoration: InputDecoration(fillColor: Color.fromARGB(168, 255,255, 255),filled: true,
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black)),
                  hintText: ('Conform Password'),prefixIcon:Icon(Icons.lock),suffixIcon: Icon(Icons.visibility_off) ),
                ),
              ),
            ),
            Padding(
          padding: const EdgeInsets.only(top:20),
          child: ElevatedButton(style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black),foregroundColor: MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            minimumSize: MaterialStatePropertyAll(Size(350,55))
          ),
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const reset()));
          }, child: Text('Update',style: GoogleFonts.inknutAntiqua(fontSize:20),)),
        )
          ],
        ) ,
      )
    ],),),

    );
  }
}