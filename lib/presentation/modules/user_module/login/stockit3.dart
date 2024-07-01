import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserLogin extends StatelessWidget {
   UserLogin({super.key});
final _usernameController = TextEditingController();
final _passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child:Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(border: OutlineInputBorder(),hintText: 'Username'
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _passWordController,
                obscureText: true,
                decoration: const InputDecoration(border: OutlineInputBorder(),hintText: 'Password'
                ),),
             SizedBox(height: 20,),
              ElevatedButton.icon(
                onPressed: () {
                  checkLogin(context);
        
                }, icon: const Icon(Icons.check), label: const Text('Login',))
            ],),
          ),
        ),
      ),
    );
  }


  void checkLogin(BuildContext ctx) {
   final _username = _usernameController.text;
   final _password = _passWordController.text;
   if(_username == _password ){
    //Goto home page
   }
   else{
    //snakbar
    // ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('User name password dosenot match')));

    // alert dialog
    showDialog(context: ctx, builder:(ctx1){
      return AlertDialog(title:Text('Error'),
       content: Text('username and password  doesnot match'),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(ctx1).pop();
        }, child: Text('close',style: GoogleFonts.abrilFatface(color:Colors.black),))
      ],
      );
    } );

    //
   }
  }
}