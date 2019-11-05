import 'package:flutter/material.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/services/auth.dart';
import 'package:panther_app/components/GoogleSignInButton.dart';

AuthService auth = AuthService();

// The Welcome/SignIn View. Has the introduction of the app and authentication
class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState(){
    super.initState();
    auth.initGoogleAuthListner((User user) {
      Navigator.pushReplacementNamed(context, '/home', arguments: user);
    });
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
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              Text(
                'Productivity done better',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.0),
              GoogleSignInButton(onPressed: auth.handleSignIn),
              SizedBox(height: 30.0),
              Container(
                width: 300,
                child: Text(
                  'By continuing, you agree to Panther\'s Terms of Service, Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
