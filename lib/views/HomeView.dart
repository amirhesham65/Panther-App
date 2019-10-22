import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panther_app/components/drawer.dart';
import 'package:panther_app/components/task_card.dart';

// The home (Today) view widget
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    TaskCard(
                      projectName: 'Rubium Studio',
                      taskTitle: 'Build the landing page',
                      taskDescription:
                          'Maybe you’ve got an idea in mind already a book you’d really love to write.',
                    ),
                    TaskCard(
                      projectName: 'Quak',
                      taskTitle: 'Rebuild the MVP',
                      taskDescription:
                          'Ask your audience what they want, and give them a few possibilities to choose from.',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
