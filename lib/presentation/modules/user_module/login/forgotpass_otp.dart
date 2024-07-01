import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/login/reset_forgetpass.dart';

class stock6 extends StatefulWidget {
  const stock6({super.key});

  @override
  State<stock6> createState() => _stock6State();
}

class _stock6State extends State<stock6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(child: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(image:DecorationImage( image:  AssetImage('images/login.png'),fit: BoxFit.cover
        )),
      child:Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 140,left:90),
                child: Center(child: Text('Enter your OTP',style: GoogleFonts.abrilFatface(fontSize:30),)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:45),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:50),
                  child: SizedBox(
                     width: 50,
                     height: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(fillColor: Color.fromARGB(168, 255, 255, 255),filled: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.black),)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                            width: 50,
                            height: 50,
                            child: TextField(inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1)],
                              decoration: InputDecoration(fillColor: Color.fromARGB(168, 255, 255, 255),filled: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.black),)),
                            ),
                          ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: TextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(1),FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(fillColor: Color.fromARGB(168, 255, 255, 255),filled: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.black),)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1)],
                        decoration: InputDecoration(fillColor: Color.fromARGB(168, 255, 255, 255),filled: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.black),)),
                    ),
                  ),
                )
              ],
            ),
          ),
        
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text('Resend OTP In',style: GoogleFonts.inknutAntiqua(fontSize:15),),
        ) ,
        Padding(
          padding: const EdgeInsets.only(top:5 ),
          child: ElevatedButton(style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black),foregroundColor: MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            minimumSize: MaterialStatePropertyAll(Size(300,55))
          ),
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const reset()));
          }, child: Text('Verify',style: GoogleFonts.inknutAntiqua(fontSize:20),)),
        )
        ],
      
      )
      
      ),
   
    ],),),

    );
  }
}