import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  // Accepting data
  final String projectName;
  final String taskTitle;
  final String taskDescription;

  TaskCard({this.projectName, this.taskTitle, this.taskDescription});

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Text(
                widget.projectName,
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.caption.color),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.taskTitle,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.taskDescription,
                style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).primaryTextTheme.caption.color),
              ),
              // Text('A card is a sheet of Material used to represent some related information, for example an album.', style: TextStyle(fontSize: 12.0, height: 1.5, color: Theme.of(context).primaryTextTheme.caption.color)),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                child: Transform.scale(
                  scale: 1,
                  child: Container(
                    width: 350.0,
                    height: 40.0,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Positioned(
                          left: 0.0,
                          child: CircleAvatar(
                            child: Text(
                              'A',
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                            backgroundColor: Colors.greenAccent[200],
                          ),
                        ),
                        Positioned(
                          left: 30.0,
                          child: CircleAvatar(
                            child: Text(
                              'K',
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                            backgroundColor: Colors.blueAccent[200],
                          ),
                        ),
                        Positioned(
                          left: 60.0,
                          child: CircleAvatar(
                            child: Text(
                              'H',
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                            backgroundColor: Colors.redAccent[200],
                          ),
                        ),
                        Positioned(
                          left: 200.0,
                          child: IconButton(
                            icon: Icon(Icons.check_circle_outline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
