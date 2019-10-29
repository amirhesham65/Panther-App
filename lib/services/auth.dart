import 'package:google_sign_in/google_sign_in.dart';

// Defining the scope of data fetched from Google Authentication
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

class AuthService {
  // The data
  GoogleSignInAccount _currentUser; 

  // Initializing the user authentication listener
  void initGoogleAuthListner(Function callBack) {
    // Listening to any SignIn/SignOut changes
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      _currentUser = account;
      if (_currentUser != null) {
        callBack(_currentUser);
      }
      // SigningIn with Google silently
      _googleSignIn.signInSilently();
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