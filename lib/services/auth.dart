import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/services/database.dart';

class AuthService {
  // Initializing GoogleSignIn and Firebase Auth 
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getting the authenticated user
  Stream<User> get user{
    return _auth.onAuthStateChanged.map((user) => user != null ? User(id: user.uid) : null);
  }

  // Handling SigningIn with google
  Future<User> handleSignInWithGoogle() async {
    // SigningIn with Google and initializing the authentication
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    // Getting and passing credentials with GoogleAuthProvider
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );

    // SigningIn with the credentials  
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

    // Setting the user data into the Firestore
    await databaseService.createUser(User.fromFirebaseUserInstance(user));

    // Returnning the user
    return User.fromFirebaseUserInstance(user);
  }

  // Handling SigningOut from Google
  Future<void> handleSignOutFromGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      print('Signed out!');
    } catch (error) {
      print(error);
    }
  }
}
