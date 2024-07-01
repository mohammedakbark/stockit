import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/login/forgotpass_otp.dart';

class forgot extends StatefulWidget {
  const forgot({super.key});

  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  final _emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String email="";
  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email has been sent')),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(child: Column(children: [Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(image:DecorationImage(image: AssetImage('images/login.png'),fit: BoxFit.cover)),
     child: Form(
      key: _formkey,
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.only(left: 50,top: 100),
             child: Text("Forget password?",style: GoogleFonts.abrilFatface(fontSize:30),),
           ),
           Padding(
             padding: const EdgeInsets.all(15.0),
             child: Padding(
               padding: const EdgeInsets.only(top: 40,left: 40),
               child: Text("We'll send a verification code to this email or phone number.",style: GoogleFonts.inknutAntiqua(fontSize:20),),
             ),
           ),
       
           SizedBox(
            height: 65,
              width: 350,
             child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter value';
                            }
                            RegExp emailRegExp = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (!emailRegExp.hasMatch(value)) {
                              return 'Please Enter valid Email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              fillColor: const Color.fromARGB(217, 255, 255, 255),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: ('Enter your Email id'),
                              prefixIcon: const Icon(Icons.email),
                              label: Text('Email ID',style: TextStyle(color: Colors.black))
                                            
                                            ),
                      ),
           ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 50),
            //   child: SizedBox(
              
            //   
            //    child: TextFormField(
            //     cursorColor: Colors.black,
            //     keyboardType: TextInputType.emailAddress,
              
            //     decoration: InputDecoration(fillColor: const Color.fromARGB(168, 255, 255, 255),filled: true,
            //     border: OutlineInputBorder(borderSide:const BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(10)),
            //     hintText: ('Enter Email/phone number')),
                
            //    ),
            //            ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.black),foregroundColor: MaterialStatePropertyAll(Colors.white),
                shape:MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
                )) ,
                minimumSize: MaterialStatePropertyAll(Size(350,55))),
                onPressed: (){
                  if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = _emailController.text;
                            resetPassword();
                          });
                  }
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>const stock6()));
                }, child: Text('Send',style: GoogleFonts.abrilFatface(fontSize:20),)),
            )
         ],
       ),
     ),
    
     ),
     
     ],),)
     

    );
  }
}