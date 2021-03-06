import 'package:flutter/material.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/services/app_state.dart';
import 'package:panther_app/services/auth.dart';
import 'package:panther_app/views/HomeView.dart';
import 'package:panther_app/views/LoadingView.dart';
import 'package:panther_app/views/SingleTaskView.dart';
import 'package:panther_app/views/SingleWorkspaceView.dart';
import 'package:panther_app/views/WelcomeView.dart';
import 'package:panther_app/views/WorkspacesView.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      AppState(
        child: MyApp(),
      ),
    );

// The main app root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
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
          '/': (context) => LoadingView(),
          '/welcome': (context) => WelcomeView(),
          '/home': (context) => HomeView(),
          '/workspaces': (context) => WorkspacesView(),
          '/workspace': (context) => SingleWorkspaceView(),
          '/task': (context) => SingleTaskView()
        },
      ),
    );
  }
}
