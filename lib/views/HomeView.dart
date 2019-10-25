import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panther_app/components/HomeTaskCard.dart';
import 'package:panther_app/components/drawer.dart';
import 'package:panther_app/task.dart';

// The home (Today) view widget
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  // Getting data from Firebase Firestore
  Widget _buildListBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tasks').snapshots(),
      // The stream gets the data and the builder process that data
      builder: (context, snapshots) {
        // Check if the snapshot has data
        if(!snapshots.hasData) return LinearProgressIndicator();
        // Build the actual task list
        return _buildTaskList(context, snapshots.data.documents);
      },
    );
  }

  // Building the actual task list
  Widget _buildTaskList(BuildContext context, List<DocumentSnapshot> snapshots) {
    return ListView(
      scrollDirection: Axis.vertical,
      // Iterating over the snapshots
      children: snapshots.map((snapshot) => _buildTaskItem(context, snapshot)).toList(),
    );
  }

  Widget _buildTaskItem(BuildContext context, DocumentSnapshot snapshot) {
    final task = Task.fromSnapshot(snapshot);
    return HomeTaskCard(
      projectName: 'Rubium Studio',
      taskTitle: task.title,
      taskDescription: task.description,
    );
  }

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
        title: Text('Home'),
        elevation: 0.0,
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
                      horizontal: 10.0, vertical: 8.0),
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
              Expanded(
                child: _buildListBody(context)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
