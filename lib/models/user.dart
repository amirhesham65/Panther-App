import 'package:firebase_auth/firebase_auth.dart';

class User {
  String id;
  String displayName;
  String email;
  String photoUrl;

  User({this.id});

  // Serializing a user object from Google into custom user object
  User.fromFirebaseUserInstance(FirebaseUser firebaseUser) {
    if (firebaseUser != null) {
      id = firebaseUser.uid;
      displayName = firebaseUser.displayName;
      email = firebaseUser.email;
      photoUrl = firebaseUser.photoUrl;
    }
  }
}
