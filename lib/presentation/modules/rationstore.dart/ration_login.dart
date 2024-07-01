import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/presentation/modules/rationstore.dart/packageration.dart';
import 'package:stockit/presentation/modules/rationstore.dart/product.dart';

class RationLogin extends StatefulWidget {
  const RationLogin({super.key});

  @override
  State<RationLogin> createState() => _RationLoginState();
}

class _RationLoginState extends State<RationLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _passWordController = TextEditingController();
  final _emailController = TextEditingController();
  String password = "", email = "";
//   login() async{
//     SharedPreferences preferences=await SharedPreferences.getInstance();
//     try {
//   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: email,
//     password: password
//   );
// preferences.setString('islogging', credential.user!.uid);
//   ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Login succesfull')));
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>productration()
//               //packages(indexnum: 0,),
// ));
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {

//     ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('user is not found')));

//   } else if (e.code == 'wrong-password') {
//      ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('wrong password')));
//   }
// }
//   }
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
                    padding:
                        const EdgeInsets.only(right: 28, left: 28, top: 100),
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
                          hintText: ('Store Id'),
                          prefixIcon: const Icon(Icons.email),
                          label: Text('Store ID',
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
                          label: Text('Password',
                              style: TextStyle(color: Colors.black))),
                    ),
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
                          minimumSize: MaterialStateProperty.all(Size(20, 55))),
                      onPressed: () {
                          Provider.of<DbController>(context,listen: false).checkStoreForLogin(
                            "Ration",
                            _emailController.text,
                            _passWordController.text,
                            packageration(indexnum: 0),
                            context); // if (_formkey.currentState!.validate()) {
                        //   setState(() {
                        //     email=_emailController.text;
                        //     password=_passWordController.text;
                        //   });

                        // }
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.inknutAntiqua(fontSize: 20),
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
