 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import 'package:stockit/presentation/modules/user_module/home/home1.dart';
import 'package:stockit/presentation/modules/user_module/login/user_login.dart';
import 'package:stockit/presentation/modules/user_module/package.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth=FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _usenameController=TextEditingController();
  final _passWordController = TextEditingController();
  final _conformpassWordController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController=TextEditingController();
  
   String email="",password="";
    Future <void> addfirebase(Map<String,dynamic>registereinfomap,String userid)async{
      try{
      await FirebaseFirestore.instance
      .collection('firebase')
    .doc(userid)

    .set(registereinfomap);
      }
      catch(e){
        print("error adding document:$e");
        throw e;
      }
    
    
  }
  String ?_password;
  String?_confirm;

   
  registration()async{
    // if(password!=null){
    //   try{
    //     UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: email, password: password);
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text("Sign up Success"))
    //     );
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home1()));
    //   }
    //   on FirebaseAuthException catch(e){
    //    if(e.code=='weak-password') {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("weak password")));
    //    }
    //    else if(e.code=='email-already-in-use'){
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("email already in use")));
    //    }

    //   }
    // }
    try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
   ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign up Success ,Login Now"))
        );
        
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>UserLogin()
              // packages(indexnum: 0,),
            ));
            //String registered_user_id = randomString(10);
            String uid =_auth.currentUser!.uid;
            Map<String,dynamic> registereinfomap = {
              "name": _usenameController.text,
              "email": _emailController.text,
              "password" : _conformpassWordController.text,
              "id":  uid ,
              "address":_addressController.text,
              "image":""
            };
            await addfirebase(registereinfomap,  uid );
            const SnackBar(content: Text("Details added to firebase Succesfully"));

} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password is weak"))
        );
  } else if (e.code == 'email-already-in-use') {
    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email is already in use"))
        );
    // print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
    
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(image:DecorationImage(image: AssetImage('images/login.png'),fit: BoxFit.cover)),
        child: Form(
           key: _formkey,
          child: Column(
           children: [
           
            Padding(
              padding: const EdgeInsets.only(top: 60,left: 60),
              child: Center(child: Text("Hello! Register to get started.",style: GoogleFonts.abrilFatface(fontSize:35),)),
            ),
             SizedBox(height: 30,),
            SizedBox(height: 80,
            width: 325,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _usenameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter name';
                        }
                        return null;
                      },
                decoration: InputDecoration(
                   focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                  fillColor: const Color.fromARGB(217, 255, 255, 255),
                  filled: true,
                  border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black),borderRadius:BorderRadius.circular(10),
              ),
              hintText:('Username'),prefixIcon: const Icon(Icons.person),
              label: Text('Username',style: TextStyle(color: Colors.black))
                ),
                
              ),
            ),
            SizedBox(height: 80,width: 325,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                 controller: _addressController,
                  validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your address';
                          }
                           
                          
                          return null;
                        },
                        keyboardType:TextInputType.emailAddress,
                  decoration: InputDecoration(
                     focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                    fillColor: const Color.fromARGB(217, 255, 255,255),filled: true,
                    border: OutlineInputBorder(borderSide:const BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(10) ),
                    hintText: ('Address'),prefixIcon: const Icon(Icons.location_history_rounded),
                  label: Text('Address',style: TextStyle(color: Colors.black))
                  ),
              ),
            ),
            SizedBox(
              height: 80,
              width: 325,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email ID';
                        }
                         RegExp emailRegExp = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Please Enter valid Email';
                        }
                        return null;
                      },
                keyboardType:TextInputType.emailAddress,
                decoration: InputDecoration(
                   focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                  fillColor: const Color.fromARGB(217, 255, 255,255),filled: true,
                  border: OutlineInputBorder(borderSide:const BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(10) ),
                  hintText: ('Email id'),prefixIcon: const Icon(Icons.email),
                label: Text('Email ID',style: TextStyle(color: Colors.black))
                ),
               
              ),
            ),
            SizedBox(
              height: 80,
              width: 325,
              child: TextFormField(autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passWordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter password';
                        }
                        return null;
                      },
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                  fillColor: const Color.fromARGB(217, 255, 255, 255),filled: true,
                  border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black),borderRadius:BorderRadius.circular(10)),
                  hintText: ('Password'),prefixIcon: const Icon(Icons.lock),suffixIcon: const Icon(Icons.visibility_off),
                  label: Text('Password',style: TextStyle(color: Colors.black))
                ),
              
              ),
            ),
            SizedBox(height:80 ,
            width: 325,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _conformpassWordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Again enter Password';
                        }
                          if((_passWordController.text != _conformpassWordController.text)){
                return "Password do not match with confirm password";
              }

                        return null;
                      },
                      
                obscureText: true,
                 decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                  fillColor: const Color.fromARGB(217, 255, 255, 255),filled: true,
                  border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black),borderRadius:BorderRadius.circular(10)),
                  hintText: ('Conform Password'),prefixIcon: const Icon(Icons.lock),suffixIcon: const Icon(Icons.visibility_off),
                label: Text('Conform password',style: TextStyle(color: Colors.black))
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),foregroundColor:MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.black),
              minimumSize: MaterialStateProperty.all(const Size(150,50)) ),
              onPressed: (){
                if (_formkey.currentState!.validate()) {
                         // Navigator.push( context,MaterialPageRoute(builder: (context) => home1()) );
                         setState(() {
                           email=_emailController.text;
                           password=_passWordController.text;
                         });
                         registration();
                        }
              }, child: Text('Sign Up',style: GoogleFonts.inknutAntiqua(fontSize:15),)),
              
              Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        TextButton(
            onPressed: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  UserLogin()));
            },
            child: const Text("Login", style: TextStyle(color: Colors.purple),)
        )
      ],
    )
           ],
           
                
          ),
        ),
      ),
    ),


    );
  }
}