import 'package:flutter/material.dart';
import 'package:panther_app/app_state.dart';
import 'package:panther_app/views/HomeView.dart';
import 'package:panther_app/views/PersonalView.dart';

void main() => runApp(AppState(child: MyApp(),));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,  
        accentColor: Colors.orange      
      ),
      home: HomeView(),
      routes: {
        '/today': (context) => HomeView(),
        '/personal': (context) => PersonalView()
      },
    );
  }
}