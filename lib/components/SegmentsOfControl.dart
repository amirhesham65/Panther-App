import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SOC extends StatefulWidget {
  @override
  _SOCState createState() => _SOCState();
}

class _SOCState extends State<SOC> {
  int _currentSegment = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl(
      unselectedColor: Theme.of(context).canvasColor,
      pressedColor: Theme.of(context).accentColor,
      groupValue: _currentSegment,
      onValueChanged: (value) {
        setState(() {
          _currentSegment = value;
        });
      },
      children: <int, Widget>{
        0: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Text("Today"),
        ),
        1: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Text("Overdue"),
        ),
        2: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Text("Up next"),
        ),
      },
    );
  }
}
