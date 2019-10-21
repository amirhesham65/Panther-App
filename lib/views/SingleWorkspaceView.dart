import 'package:flutter/material.dart';

class SingleWorkspaceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quak'),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.multiline_chart),
            )
          )
        ],
      ),
    );
  }
}
