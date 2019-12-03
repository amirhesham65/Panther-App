import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panther_app/components/SegmentsOfControl.dart';
import 'package:panther_app/components/TaskCard.dart';
import 'package:panther_app/models/task.dart';
import 'package:panther_app/models/workspace.dart';
import 'package:panther_app/services/database.dart';
import 'package:panther_app/views/AddTask.dart';

// Showing Add Task View
void showAddTaskView(BuildContext context, String curentWorkspaceId) {
  Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.downToUp,
      child: AddTask(currentWorkspaceId: curentWorkspaceId),
    ),
  );
}

// Single Workspace view that shows tasks, chat and statistics
class SingleWorkspaceView extends StatefulWidget {
  @override
  _SingleWorkspaceViewState createState() => _SingleWorkspaceViewState();
}

class _SingleWorkspaceViewState extends State<SingleWorkspaceView> {
  // Getting data from Firebase Firestore
  Widget _buildListBody(BuildContext context) {
    final Workspace workspace = ModalRoute.of(context).settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: databaseService.getWorkspaceTasks(workspace.reference.documentID),
      // The stream gets the data and the builder process that data
      builder: (context, snapshots) {
        // Check if the snapshot has data
        if (!snapshots.hasData) return LinearProgressIndicator();
        // Build the actual task list
        return _buildTaskList(context, snapshots.data.documents);
      },
    );
  }

  // Building the actual task list
  Widget _buildTaskList(
      BuildContext context, List<DocumentSnapshot> snapshots) {
    return ListView(
      scrollDirection: Axis.vertical,
      // Iterating over the snapshots
      children: snapshots
          .map((snapshot) => _buildTaskItem(context, snapshot))
          .toList(),
    );
  }

  // Building each task list item
  Widget _buildTaskItem(BuildContext context, DocumentSnapshot snapshot) {
    final task = Task.fromSnapshot(snapshot);
    return TaskCard(task: task);
  }

  @override
  Widget build(BuildContext context) {
    // Recieving the workspace from route arguments
    final Workspace workspace = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showAddTaskView(context, workspace.reference.documentID),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text(workspace.name),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.insert_chart),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Center(
                child: SOC(),
              ),
              SizedBox(
                height: 12.0,
              ),
              Expanded(child: _buildListBody(context))
            ],
          ),
        ),
      ),
    );
  }
}
