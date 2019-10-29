import 'package:google_sign_in/google_sign_in.dart';

class User {
  String id;
  String displayName;
  String email;
  String photoUrl;

  // Serializing a user object from Google into custom user object
  User.fromGoogleSignInAcccount(GoogleSignInAccount googleSignInAccount) {
    if (googleSignInAccount != null) {
      id = googleSignInAccount.id;
      displayName = googleSignInAccount.displayName;
      email = googleSignInAccount.email;
      photoUrl = googleSignInAccount.photoUrl;
    }
  }
}
