import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskCard extends StatefulWidget {
  // Accepting task data
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
      child: Container(
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
                Row(
                    children: <Widget>[
                      Icon(Icons.flag, color: Colors.blueAccent,),
                      Expanded(
                        child: LinearPercentIndicator(
                          percent: 0.25,
                          progressColor: Theme.of(context).accentColor,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.check_circle_outline),
                        color: Colors.grey,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
