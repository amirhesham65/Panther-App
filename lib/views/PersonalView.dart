import 'package:flutter/material.dart';

class PersonalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Personal'),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
            child: CircleAvatar(
              child: Text('A'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[Task(title: 'A text field lets the user enter text, either with a hardware.',), Task(title: 'Define the routes by providing additional properties to the MaterialApp.'), Task(title: 'With the widgets and routes in place, trigger navigation by using.',)],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Task extends StatelessWidget {
  Task({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.check_circle_outline),
      ),
      contentPadding: const EdgeInsets.all(0.0),
      title: Text(title),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: Text(
          'Sep 6',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
    );
  }
}
