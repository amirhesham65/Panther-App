import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  // Accepting the onPressed Function
  final Function onPressed;
  GoogleSignInButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          width: 240,
          decoration: BoxDecoration(color: Color.fromRGBO(211, 21, 21, 0.15)),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/images/Google.png')),
              SizedBox(width: 10.0),
              Text(
                'Continue with Google',
                style: TextStyle(
                  color: Color.fromRGBO(211, 21, 21, 1),
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
