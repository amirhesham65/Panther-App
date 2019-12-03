import 'package:flutter/material.dart';
import 'package:panther_app/models/task.dart';
import 'package:panther_app/services/database.dart';
import 'package:panther_app/views/SingleTaskView.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeTaskCard extends StatefulWidget {
  // Accepting task data
  final Task task;

  HomeTaskCard({
    this.task
  });

  @override
  _HomeTaskCardState createState() => _HomeTaskCardState();
}

class _HomeTaskCardState extends State<HomeTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Container(
        child: Opacity(
          opacity: (widget.task.isCompleted) ? 0.6 : 1,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SingleTaskView(task: widget.task,)),
            ),
            child: Hero(
              tag: 'task_' + widget.task.reference.documentID,
                          child: Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Text(
                        widget.task.workspaceName,
                        style: TextStyle(
                          color: Theme.of(context).primaryTextTheme.caption.color,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        widget.task.title,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3),
                      ),
                      (widget.task.description != null)
                          ? Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                              child: Text(
                                widget.task.description,
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
                                widget.task.reference.documentID, widget.task.isCompleted),
                            icon: (widget.task.isCompleted)
                                ? Icon(Icons.check_circle)
                                : Icon(Icons.check_circle_outline),
                            color: (widget.task.isCompleted)
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
        ),
      ),
    );
  }
}
