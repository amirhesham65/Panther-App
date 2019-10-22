import 'package:flutter/material.dart';
import 'package:panther_app/components/SegmentsOfControl.dart';
import 'package:panther_app/components/WorkspaceTaskCard.dart';

// Single Workspace view that shows tasks, chat and statistics
class SingleWorkspaceView extends StatelessWidget {
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
        title: Text('Quak'),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: SOC(),
              ),
              SizedBox(
                height: 12.0,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    WorkspaceTaskCard(
                      taskStatus: 'Overdue',
                      taskTitle: 'Wireframing the application',
                      taskDescription: 'Starting to wireframe the layout of the next big app with all the elements needed.',
                    ),
                    WorkspaceTaskCard(
                      taskStatus: 'Up Next',
                      taskTitle: 'July meeting preperation',
                      taskDescription: 'APIs curated by RapidAPI and recommended based on functionality offered, performance, and support.',
                    ),
                    WorkspaceTaskCard(
                      taskStatus: 'Today',
                      taskTitle: 'Revisiting the APIs and endpoints',
                      taskDescription: 'Welcome to SendGrid’s Web API v3! This API is RESTful.',
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
