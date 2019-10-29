import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:panther_app/components/GoogleSignInButton.dart';

// Defining the scope of data fetched from Google Authentication
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

// The Welcome/SignIn View. Has the introduction of the app and authentication
class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  GoogleSignInAccount _currentUser; // Saving the user in the state

  @override
  void initState() {
    super.initState();
    // Listening to any SignIn/SignOut changes
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        // Update the user instance in the state
        _currentUser = account;
        // Check if user instance was fetched
        if (_currentUser != null) {
          print(_currentUser.displayName);
        }
      });
      // SigningIn with Google silently
      _googleSignIn.signInSilently();
    });
  }

  // Handling SigningIn with Google
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  // Handling SigningOut from Google
  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Panther',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
              ),
              Text(
                'Productivity done better',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.0),
              GoogleSignInButton(onPressed: _handleSignIn),
              SizedBox(height: 30.0),
              Container(
                width: 300,
                child: Text(
                  'By continuing, you agree to Panther\'s Terms of Service, Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
