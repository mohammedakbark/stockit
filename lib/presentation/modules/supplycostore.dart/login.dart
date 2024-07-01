import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class slogin extends StatefulWidget {
  const slogin({super.key});

  @override
  State<slogin> createState() => _sloginState();
}

class _sloginState extends State<slogin> {
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
  final _passWordController = TextEditingController();
  final _emailController = TextEditingController();
  String password="",email="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/login.png'), fit: BoxFit.cover)),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 28, left: 28),
                    child: Center(
                      child: Text('Welcome back! Glad to see you Again!',
                          style: GoogleFonts.abrilFatface(
                              fontSize: 30, color: Colors.black)),
                    ),
                  ),
                  //Text('Email'),
                  SizedBox(height: 70),
                  SizedBox(
                    height: 90,
                    width: 310,
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
                  ),),
                
                  SizedBox(
                    height: 90,
                    width: 310,
                    child: TextFormField(
                      controller: _passWordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter value';
                        }
                        return null;
                      },
                      obscureText: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          fillColor: const Color.fromARGB(217, 255, 255, 255),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          hintText: ('Enter your Password'),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: const Icon(Icons.visibility_off),
                          label: Text('Password',style: TextStyle(color: Colors.black))
                          ),
                          
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 180,
                  //   ),
                  //   child: TextButton(
                  //       onPressed: () {
                  //         // Navigator.push(
                  //         //     context,
                  //         //     MaterialPageRoute(
                  //         //         builder: (context) => const forgot()));
                  //       },
                  //       child: Text('Forgot password?',
                  //           style: GoogleFonts.inknutAntiqua(
                  //               fontSize: 12, color: Colors.black))),
                  // ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          minimumSize: MaterialStateProperty.all(Size(20, 55))),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email=_emailController.text;
                            password=_passWordController.text;
                          });
                          
                        }
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.inknutAntiqua(fontSize: 20),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.black,
                        )),
                        Text(
                          'Or Login With',
                          style: GoogleFonts.inknutAntiqua(fontSize: 13),
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.black,
                        )),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}