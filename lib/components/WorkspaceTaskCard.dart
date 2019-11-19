import 'package:flutter/material.dart';
import 'package:panther_app/services/database.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkspaceTaskCard extends StatefulWidget {
  // Accepting task data
  final String taskStatus;
  final String taskId;
  final String taskTitle;
  final String taskDescription;
  final String taskWorkspaceName;
  final bool taskIsCompleted;

  WorkspaceTaskCard({
    this.taskStatus,
    this.taskId,
    this.taskTitle,
    this.taskDescription,
    this.taskWorkspaceName,
    this.taskIsCompleted,
  });

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
        child: Opacity(
          opacity: (widget.taskIsCompleted) ? 0.6 : 1,
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
                      fontWeight: FontWeight.w600,
                      color: taskStatusColor(widget.taskStatus),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                      widget.taskTitle,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3
                      ),
                    ),
                  (widget.taskDescription != null)
                      ? Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                          child: Text(
                            widget.taskDescription,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .caption
                                  .color,
                            ),
                          ),
                        )
                      : Container(),
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
                        onPressed: () => databaseService.completeTask(
                            widget.taskId, widget.taskIsCompleted),
                        icon: (widget.taskIsCompleted)
                            ? Icon(Icons.check_circle)
                            : Icon(Icons.check_circle_outline),
                        color: (widget.taskIsCompleted)
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
