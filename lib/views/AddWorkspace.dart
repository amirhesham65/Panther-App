import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/services/app_state.dart';
import 'package:panther_app/services/database.dart';

class AddWorkspace extends StatefulWidget {
  @override
  _AddWorkspaceState createState() => _AddWorkspaceState();
}

// The Add Task model to submit new tasks
class _AddWorkspaceState extends State<AddWorkspace> {
  final _formKey = GlobalKey<FormState>();

  // Holding the state
  String workspaceName;
  String workspaceDescription;

  @override
  Widget build(BuildContext context) {
    // Getting current user
    User _currentUser = AppState.of(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black26
            : Colors.white,
        title: Text('Create workspace'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              await databaseService.createWorkspace(currentUser: _currentUser, workspaceName: workspaceName, workspaceDescription: workspaceDescription);
              Navigator.pop(context);
            },
            child: Text(
              'Done',
              style: TextStyle(color: Colors.orange),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                onChanged: (String value) {
                  setState(() {
                    workspaceName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Workspace name',
                  helperText: 'eg. Company X',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                onChanged: (String value) {
                  setState(() {
                    workspaceDescription = value;
                  });
                },
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Workspace description',
                  helperText: 'Describe your workspace briefly',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}