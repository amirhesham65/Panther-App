import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:panther_app/models/user.dart';

// Defining the scope of data fetched from Google Authentication
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

class AuthService {
  // The data
  User _currentUser;

  // Initializing the user authentication listener
  void initGoogleAuthListner(Function callBack) {
    // Listening to any SignIn/SignOut changes
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount googleSignInAccount) {
      _currentUser = User.fromGoogleSignInAcccount(googleSignInAccount);
      // Check if the Google user object was fetched
      if (_currentUser != null) {
        // Check if the user was already in Firestore DB
        Firestore.instance
            .collection('users')
            .where('email', isEqualTo: _currentUser.email)
            .snapshots()
            .listen((data) {
          if (data.documents.length == 0) {
            // Add the user to database
            addNewUserToDatabase(_currentUser);
          }
        });
        callBack(_currentUser);
      }
      // SigningIn with Google silently
      _googleSignIn.signInSilently();
    });
  }

  // Add user to the firestore
  void addNewUserToDatabase(User userToAdd) {
    Firestore.instance.collection('users').document().setData({
      'googleId': userToAdd.id,
      'displayName': userToAdd.displayName,
      'email': userToAdd.email,
      'photoUrl': userToAdd.photoUrl
    });
  }

  // Handling SigningIn with Google
  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  // Handling SigningOut from Google
  Future<void> handleSignOut() async {
    await _googleSignIn.disconnect();
    print('Disconnected!');
  }
}
