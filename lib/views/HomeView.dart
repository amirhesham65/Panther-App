import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panther_app/components/HomeTaskCard.dart';
import 'package:panther_app/components/drawer.dart';
import 'package:panther_app/models/task.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/services/app_state.dart';
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
  Widget _buildListBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tasks').snapshots(),
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
    return HomeTaskCard(
      taskId: task.reference.documentID,
      taskWorkspaceName: task.workspaceName,
      taskTitle: task.title,
      taskDescription: task.description,
      taskIsCompleted: task.isCompleted,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null) {
      AppState.of(context).setUserState(ModalRoute.of(context).settings.arguments);
    }
    
    // Today's date initialization
    final DateTime now = DateTime.now();
    // Getting the current user from the Provider
    final User user = Provider.of<User>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskView(context),
        
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
        elevation: 0.5,
        backgroundColor: Theme.of(context).canvasColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
            child: CircleAvatar(
              child: Text('A'),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      Text(
                        'Thu Sep 12',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 8.0,
              ),
              // Listing all today's tasks
              Expanded(child: _buildListBody(context)),
            ],
          ),
        ),
      ),
    );
  }
}
