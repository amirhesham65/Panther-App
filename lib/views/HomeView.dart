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
  int _currentSegment = 0;
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
          title: Text('Today'),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Center(
                  child: CupertinoSegmentedControl(
                    unselectedColor: Theme.of(context).canvasColor,
                    pressedColor: Theme.of(context).accentColor,
                    groupValue: _currentSegment,
                    onValueChanged: (value) {
                      setState(() {
                        _currentSegment = value;
                      });
                    },
                    children: <int, Widget>{
                      0: Padding(padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0), child: Text("Recent"),),
                      1: Padding(padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0), child: Text("Projects"),),
                      2: Padding(padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0), child: Text("Personal"),),
                    },
                  ),
                ),
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
        ));
  }
}
