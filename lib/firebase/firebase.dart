import 'package:cloud_firestore/cloud_firestore.dart';

class firebaseHelper{
  final _firebase=FirebaseFirestore.instance;
  Future addfirebase(
    Map<String,dynamic>registereduserinfomap,String userid)async

    {
      return _firebase
      .collection('firebase')
      .doc(userid)
      .set(registereduserinfomap);

}


}