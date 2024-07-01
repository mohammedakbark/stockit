import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockit/data/firebase/authentication/auth_service.dart';
import 'package:stockit/data/helper/login_preference.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/presentation/modules/admin/adminlogin.dart';
import 'package:stockit/presentation/modules/mavelistore%20module/maveli_login.dart';
import 'package:stockit/presentation/modules/neethi%20store/neethi_login.dart';
import 'package:stockit/presentation/modules/rationstore.dart/ration_login.dart';
import 'package:stockit/presentation/modules/supplycostore.dart/suplyco_login.dart';
import 'package:stockit/presentation/modules/user_module/home/home1.dart';
import 'package:stockit/presentation/modules/user_module/login/sign_up.dart';
// import 'package:stockit/forgot.dart';
import 'package:stockit/presentation/modules/user_module/login/forgotpass.dart';
import 'package:stockit/presentation/modules/user_module/package.dart';

class UserLogin extends StatefulWidget {
  UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _passWordController = TextEditingController();
  final _emailController = TextEditingController();
  String password = "", email = "";

  bool isPasswordVisible = false;
//   login() async{
//     SharedPreferences preferences=await SharedPreferences.getInstance();
//     try {
//   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: email,
//     password: password
//   );
//   preferences.setString('islogging', credential.user!.uid);
//   ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text('Login succesfull')));
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>const home1()
//               //packages(indexnum: 0,),
// ));
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {

//     ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text('user is not found')));

//   } else if (e.code == 'wrong-password') {
//      ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text('wrong password')));
//   }
// }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AdminLogin()));
              },
              icon: const Icon(Icons.motion_photos_auto_rounded)),

          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RationLogin()));
                        },
                        child: const Text("Ration Store")),
                    PopupMenuItem(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MaveliLogin()));
                        },
                        child: const Text("Maveli Store")),
                    PopupMenuItem(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SuplycoLogin()));
                        },
                        child: const Text("Supplyco Store")),
                    PopupMenuItem(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const NeethiLogin()));
                        },
                        child: const Text("Neethi Store"))
                  ])
          // IconButton(onPressed: () {

          // }, icon: Icon(Icons.more_vert)),
        ],
      ),
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
                  const SizedBox(
                    height: 150,
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
                  const SizedBox(height: 70),
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
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          fillColor: const Color.fromARGB(217, 255, 255, 255),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          hintText: ('Enter your Email id'),
                          prefixIcon: const Icon(Icons.email),
                          label: const Text('Email ID',
                              style: TextStyle(color: Colors.black))),
                    ),
                  ),

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
                      obscureText: isPasswordVisible,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          fillColor: const Color.fromARGB(217, 255, 255, 255),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          hintText: ('Enter your Password'),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            // icon: Icon(Icons.visibility_off)
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          label: const Text('Password',
                              style: TextStyle(color: Colors.black))),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 180,
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const forgot()));
                        },
                        child: Text('Forgot password?',
                            style: GoogleFonts.inknutAntiqua(
                                fontSize: 12, color: Colors.black))),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(       
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                   foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          minimumSize:
                              MaterialStateProperty.all(const Size(20, 55))),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = _emailController.text;
                            password = _passWordController.text;
                          });
                          AuthService()
                              .loginWithEmailAndPassword(_emailController.text,
                                  _passWordController.text, context)
                              .then((value) {
                            if (FirebaseAuth.instance.currentUser!.uid ==
                                Services.ADMIN_UID) {
                              Services.errorMessage(
                                  context, "Invalid Credential!");
                              LoginPreference.removePreference(context);
                            } else {
                              LoginPreference.setPreference(
                                  FirebaseAuth.instance.currentUser!.uid);
                              Services.successMessage(
                                  context, "Login Successful!");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const home1()),
                                  (route) => false);
                            }
                          });
                        }
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.inknutAntiqua(fontSize: 20),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dont have an account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.purple),
                          ))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
