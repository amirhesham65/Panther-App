import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panther_app/components/TaskCard.dart';
import 'package:panther_app/components/drawer.dart';
import 'package:panther_app/models/task.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/services/database.dart';
import 'package:panther_app/views/AddTask.dart';
import 'package:provider/provider.dart';

// The home (Today) view widget
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

// Showing Add Task View
void showAddTaskView(BuildContext context) {
  Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.downToUp,
      child: AddTask(),
    ),
  );
}

class _HomeViewState extends State<HomeView> {
  // Placeholder to display when there is no data (tasks)
  Widget _todayTasksPlaceHolder() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Opacity(
              opacity: 0.7,
              child: Image(
                image: AssetImage('assets/images/no_tasks.png'),
                width: 300,
              ),
            ),
            Text(
              'What do you want to accomplish today?',
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
            SizedBox(height: 24.0),
            RaisedButton(
              onPressed: () => showAddTaskView(context),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Add a task',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Getting data from Firebase Firestore
  Widget _buildListBody(BuildContext context, User user) {
    return StreamBuilder<QuerySnapshot>(
      stream: databaseService.getUsersTasks(user),
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
    if (snapshots.length == 0) {
      return _todayTasksPlaceHolder();
    }
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
    // Getting the current user from the Provider
    User user = Provider.of<User>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskView(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Mismo'),
        elevation: 0.7,
        backgroundColor: Theme.of(context).canvasColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.6),
              child: (user.photoUrl != null)
                  ? ClipOval(
                      child: Image.network(
                        user.photoUrl,
                        width: 35.0,
                      ),
                    )
                  : Text(user.displayName[0]),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 12.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 7.0),
                    Text(
                      'Thu Sep 12',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Listing all today's tasks
              Expanded(child: _buildListBody(context, user)),
            ],
          ),
        ),
      ),
    );
  }
}
