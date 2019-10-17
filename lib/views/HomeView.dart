import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panther_app/components/drawer.dart';
import 'package:panther_app/components/task_card.dart';

// The home (Today) view widget
class HomeView extends StatelessWidget {
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
                    unselectedColor: Colors.orange[300],
                    pressedColor: Colors.orange,
                    selectedColor: Colors.white,
                    onValueChanged: (value) {},
                    children: <Key, Widget>{
                      UniqueKey(): Padding(padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0), child: Text("Recent"),),
                      UniqueKey(): Padding(padding: EdgeInsets.all(3.0), child: Text("Priority"),),
                      UniqueKey(): Padding(padding: EdgeInsets.all(3.0), child: Text("Projects"),),
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
