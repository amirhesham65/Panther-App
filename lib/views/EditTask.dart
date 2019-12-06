import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/models/workspace.dart';
import 'package:panther_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditTask extends StatefulWidget {
  final DocumentSnapshot task;

  EditTask({this.task});

  @override
  _EditTaskState createState() => _EditTaskState();
}

// The Add Task model to submit new tasks
class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();

  // Holding the state
  String taskTitle;
  String taskDescription;
  String taskWorkspaceId;
  String taskAssignedUserId;
  String taskAssignedUserName;
  DateTime schedule = DateTime.now();

  // Setting up the material date picker for task schedule
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: schedule,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != schedule) {
      setState(() {
        schedule = pickedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    taskTitle = widget.task['title'];
    taskDescription = widget.task['description'];
    taskWorkspaceId = widget.task['workspaceId'];
    taskAssignedUserId = widget.task['userAssignedId'];
    schedule = widget.task['schedule'].toDate();
  }

  // Setting the assigned user Id to the state
  void setAssignedUser(user) {
    setState(() {
      taskAssignedUserId = user['id'];
      taskAssignedUserName = user['displayName'];
    });
  }

  // Show the user assignment
  Future<void> _openUserAssignment() async {
    // Building each task list item
    Widget _buildUserItem(
        BuildContext context, DocumentSnapshot snapshot, Function closeDialog) {
      Map user = snapshot.data;
      return ListTile(
        onTap: () {
          setAssignedUser(user);
          closeDialog();
        },
        title: Text(user['displayName']),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.6),
          child: (user['photoUrl'] != null)
              ? ClipOval(
                  child: Image.network(
                    user['photoUrl'],
                    width: 35.0,
                  ),
                )
              : Text(user['displayName'][0]),
        ),
        trailing: Icon(Icons.check),
      );
    }

    // Building the actual task list
    Widget _buildUserList(BuildContext context,
        List<DocumentSnapshot> snapshots, Function closeDialog) {
      return ListBody(
        // Iterating over the snapshots
        children: snapshots
            .map((snapshot) => _buildUserItem(context, snapshot, closeDialog))
            .toList(),
      );
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        void closeDialog() => Navigator.pop(context);
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          title: Text('Choose a person'),
          content: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
            stream: databaseService.getWorkspaceUsers(taskWorkspaceId),
            builder: (context, snapshots) {
              // Check if the snapshot has data
              if (!snapshots.hasData) return LinearProgressIndicator();
              // Build the actual task list
              return _buildUserList(
                  context, snapshots.data.documents, closeDialog);
            },
          )),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Getting the current user from the provider
    final User currentUser = Provider.of<User>(context);

    // Build the workspace choosing dropdown menu widget
    Widget _buildDropDown(BuildContext context,
        List<DocumentSnapshot> snapshots, String fetchedTaskWorkspaceId) {
      List<Workspace> workspaces = snapshots
          .map((snapshot) => Workspace.fromSnapshot(snapshot))
          .toList();
      return DropdownButton<String>(
        isExpanded: true,
        hint: Text('Choose a workspace'),
        value: fetchedTaskWorkspaceId ?? taskWorkspaceId,
        onChanged: (val) async {
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

    // Build the workspace choosing dropdown menu stream
    Widget _buildWorkspacesDropDown(String workspaceId) {
      return StreamBuilder<QuerySnapshot>(
        stream: databaseService.getUsersWorkspaces(currentUser),
        builder: (context, snapshots) {
          if (!snapshots.hasData) return LinearProgressIndicator();
          return _buildDropDown(context, snapshots.data.documents, workspaceId);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black26
            : Colors.white,
        title: Text('Edit Task'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              databaseService.editTask(
                  taskId: widget.task.reference.documentID,
                  taskTitle: taskTitle,
                  taskDescription: taskDescription,
                  workspaceId: taskWorkspaceId,
                  schedule: schedule,
                  assignedUserId: taskAssignedUserId);
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
                    taskTitle = value;
                  });
                },
                initialValue: taskTitle,
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
              _buildWorkspacesDropDown(taskWorkspaceId),
              SizedBox(height: 8.0),
              TextFormField(
                onChanged: (String value) {
                  setState(() {
                    taskDescription = value;
                  });
                },
                maxLines: null,
                initialValue: taskDescription,
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
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                )),
                child: ListTile(
                  onTap: () async {
                    setState(() {
                      taskWorkspaceId = taskWorkspaceId;
                    });
                    await _openUserAssignment();
                  },
                  leading: Icon(Icons.person),
                  title: Text('Assigned to'),
                  subtitle: Text(taskAssignedUserName ?? ""),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                )),
                child: ListTile(
                  onTap: () => _selectDate(context),
                  leading: Icon(Icons.calendar_today),
                  title: Text('Schedule'),
                  subtitle: Text(DateFormat('EE dd MMM yyyy').format(schedule)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
