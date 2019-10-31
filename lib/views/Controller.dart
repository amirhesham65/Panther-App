import 'package:flutter/material.dart';

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  @override
  Widget build(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
    return Scaffold(
      body: Container(),
    );
  }
}