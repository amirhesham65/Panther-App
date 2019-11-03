import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:panther_app/services/app_state.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    if(AppState.of(context).currentUser != null) {
      Future.delayed(Duration(seconds: 2)).then((val) {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }else {
      Future.delayed(Duration(seconds: 2)).then((val) {
        Navigator.pushReplacementNamed(context, '/welcome');
      });
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitWave(
              color: Colors.black87,
              size: 30,
            ),
            SizedBox(height: 18.0),
            Text(
              'Welcome onboard!',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}