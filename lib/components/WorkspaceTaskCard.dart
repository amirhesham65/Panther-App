import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkspaceTaskCard extends StatefulWidget {
  // Accepting task data
  final String taskStatus;
  final String taskTitle;
  final String taskDescription;

  WorkspaceTaskCard({this.taskStatus, this.taskTitle, this.taskDescription});

  @override
  _WorkspaceTaskCardState createState() => _WorkspaceTaskCardState();
}

// A function to return the color of the taskStatus based on its value
Color taskStatusColor(String taskStatus) {
  // Checking for the value of the taskStatus
  switch (taskStatus) {
    case 'Today':
      return Colors.green[300];
      break;
    case 'Overdue':
      return Colors.red[300];
      break;
    case 'Up Next':
      return Colors.blue[300];
      break;
  }
  return Colors.orange[300];
}

class _WorkspaceTaskCardState extends State<WorkspaceTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Container(
        // To be extracted later
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text(
                  widget.taskStatus,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: taskStatusColor(widget.taskStatus),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  widget.taskTitle,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  widget.taskDescription ?? '',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).primaryTextTheme.caption.color,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.flag, color: Colors.grey),
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
