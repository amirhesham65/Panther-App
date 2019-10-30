import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/services/app_state.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context).settings.arguments != null) {
      AppState.of(context).setUserState(ModalRoute.of(context).settings.arguments);
    }
    User user = AppState.of(context).currentUser;
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
              'Happy to have you onboard, ${user.displayName.split(' ')[0]}!',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}