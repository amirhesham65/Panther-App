import 'package:flutter/material.dart';
import 'package:panther_app/components/SegmentsOfControl.dart';
import 'package:panther_app/components/task_card.dart';

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
          )
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
                    TaskCard(
                      projectName: 'Rubium Studio',
                      taskTitle: 'Build the landing page',
                      taskDescription:
                          'Maybe you’ve got an idea in mind already a book you’d really love to write.',
                    ),
                    TaskCard(
                      projectName: 'Rubium Studio',
                      taskTitle: 'Build the landing page',
                      taskDescription:
                          'Maybe you’ve got an idea in mind already a book you’d really love to write.',
                    ),
                    TaskCard(
                      projectName: 'Rubium Studio',
                      taskTitle: 'Build the landing page',
                      taskDescription:
                          'Maybe you’ve got an idea in mind already a book you’d really love to write.',
                    ),
                    TaskCard(
                      projectName: 'Rubium Studio',
                      taskTitle: 'Build the landing page',
                      taskDescription:
                          'Maybe you’ve got an idea in mind already a book you’d really love to write.',
                    ),
                    TaskCard(
                      projectName: 'Rubium Studio',
                      taskTitle: 'Build the landing page',
                      taskDescription:
                          'Maybe you’ve got an idea in mind already a book you’d really love to write.',
                    ),
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
