import 'package:flutter/material.dart';
import 'package:panther_app/services/app_state.dart';
import 'package:panther_app/views/HomeView.dart';
import 'package:panther_app/views/LoadingView.dart';
import 'package:panther_app/views/PersonalView.dart';
import 'package:panther_app/views/SingleWorkspaceView.dart';
import 'package:panther_app/views/WelcomeView.dart';
import 'package:panther_app/views/WorkspacesView.dart';

void main() => runApp(
      AppState(
        child: MyApp(),
      ),
    );

// The main app root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debugModeBanner
      debugShowCheckedModeBanner: false,
      // Theme controlling
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        accentColor: Colors.orange,
      ),
      initialRoute: '/',
      // Defining app routes
      routes: {
        '/': (context) => WelcomeView(),
        '/loading': (context) => LoadingView(),
        '/home': (context) => HomeView(),
        '/personal': (context) => PersonalView(),
        '/workspaces': (context) => WorkspacesView(),
        '/workspace': (context) => SingleWorkspaceView(),
      },
    );
  }
}
