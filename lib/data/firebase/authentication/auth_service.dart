import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockit/data/helper/service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future loginWithEmailAndPassword(email, password, context) async {
    try {
           await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Services.errorMessage(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Services.errorMessage(
            context, 'Wrong password provided for that user.');
      } else {
        Services.errorMessage(context, e.toString());
      }
    } catch (e) {
      Services.errorMessage(context, e.toString());
    }
  }
}
