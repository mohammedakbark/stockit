import 'package:flutter/material.dart';

class Services{

static var ADMIN_PASSOWORD="admin@123";
static var ADMIN_EMAIL="stockit@gmail.com";
static var ADMIN_UID="Cv3TlystJTeyrvbpU1zmxGP1F6n1";



 static errorMessage(context,errorMessage)async{
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  
  backgroundColor: Colors.red,
  content: Text(errorMessage)));

}
 static successMessage(context,successMessage)async{
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  backgroundColor: Colors.green,
  content: Text(successMessage)));

}


 static w(context){
  return MediaQuery.of(context).size.width;
}
static h(context){
  return MediaQuery.of(context).size.height;
}

}