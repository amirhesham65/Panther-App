import 'package:flutter/material.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/views/HomeView.dart';
import 'package:panther_app/views/WelcomeView.dart';
import 'package:provider/provider.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return WelcomeView();
    } else {
      return HomeView();
    }
  }
}
