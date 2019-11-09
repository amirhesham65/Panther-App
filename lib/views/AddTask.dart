import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/models/workspace.dart';
import 'package:panther_app/services/database.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {

  final String currentWorkspaceId;

  AddTask({this.currentWorkspaceId});

  @override
  _AddTaskState createState() => _AddTaskState();
}

// The Add Task model to submit new tasks
class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  // Holding the state
  String taskTitle;
  String taskDescription;
  String taskWorkspaceId;

  @override
  void initState() {
    super.initState();
    taskWorkspaceId = widget.currentWorkspaceId;
  }

  @override
  Widget build(BuildContext context) {
    final User currentUser = Provider.of<User>(context);

    Widget _buildDropDown(
        BuildContext context, List<DocumentSnapshot> snapshots) {
      List<Workspace> workspaces = snapshots
          .map((snapshot) => Workspace.fromSnapshot(snapshot))
          .toList();
      return DropdownButton<String>(
        isExpanded: true,
        hint: Text('Choose a workspace'),
        value: taskWorkspaceId,
        onChanged: (val) {
          setState(() {
            taskWorkspaceId = val;
          });
        },
        items: workspaces.map((Workspace workspace) {
          return DropdownMenuItem<String>(
            value: workspace.reference.documentID,
            child: Text(workspace.name),
          );
        }).toList(),
      );
    }

    Widget _buildWorkspacesDropDown() {
      return StreamBuilder<QuerySnapshot>(
        stream: databaseService.getUsersWorkspaces(currentUser),
        builder: (context, snapshots) {
          if (!snapshots.hasData) return LinearProgressIndicator();
          return _buildDropDown(context, snapshots.data.documents);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black26
            : Colors.white,
        title: Text('Add Task'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              databaseService
                  .createTask(
                    taskTitle: taskTitle,
                    taskDescription: taskDescription,
                    workspaceId: taskWorkspaceId,
                  )
                  .then((val) => Navigator.pop(context));
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
                    taskTitle = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Task name',
                  helperText: 'eg. Design the layout',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              _buildWorkspacesDropDown(),
              SizedBox(height: 8.0),
              TextFormField(
                onChanged: (String value) {
                  setState(() {
                    taskDescription = value;
                  });
                },
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Task description',
                  helperText: 'Describe your task in short sentence',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey[200], )),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Assigned to'),
                  subtitle: Text('Amir Hesham'),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey[200], )),
                child: ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Schedule'),
                  subtitle: Text('Sat, 10/12/19'),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey[200], )),
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Remind on a location'),
                  subtitle: Text('Amir Hesham\'s Home'),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
