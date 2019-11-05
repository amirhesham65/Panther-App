import 'package:google_sign_in/google_sign_in.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/services/database.dart';

// Defining the scope of data fetched from Google Authentication
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

class AuthService {
  // The data
  User currentUser;

  // Initializing the user authentication listener
  Future<void> initGoogleAuthListner(Function callBack) async {
    // Listening to any SignIn/SignOut changes
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount googleSignInAccount) async {
      currentUser = User.fromGoogleSignInAcccount(googleSignInAccount);
      if(currentUser != null) {
        callBack(await databaseService.createUser(currentUser));
      }
      // SigningIn with Google silently
      await _googleSignIn.signInSilently();
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
