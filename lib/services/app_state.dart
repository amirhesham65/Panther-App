import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Creating an inheritedWidget to contain the app state
class _AppStateContainer extends InheritedWidget {
  // Collecting the entire state
  final _AppStateState data;
  _AppStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  @override
  bool updateShouldNotify(_AppStateContainer oldWidget) => true;
}

class AppState extends StatefulWidget {
  final Widget child;
  AppState({@required this.child});
  // This basically says 'get the data from the widget of this type.
  static _AppStateState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_AppStateContainer)
            as _AppStateContainer)
        .data;
  }

  @override
  _AppStateState createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  GoogleSignInAccount currentUser;

  // Setting the user in the state
  void setUser(GoogleSignInAccount fetchedAccout) {
    currentUser = fetchedAccout;
  }

  @override
  Widget build(BuildContext context) {
    return _AppStateContainer(
      data: this,
      child: widget.child,
    );
  }
}
