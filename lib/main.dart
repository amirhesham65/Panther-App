import 'package:flutter/material.dart';
import 'package:panther_app/views/HomeView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,        
      ),
      home: HomeView(),
    );
  }
}