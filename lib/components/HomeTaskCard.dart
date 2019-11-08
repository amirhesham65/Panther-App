import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeTaskCard extends StatefulWidget {
  // Accepting task data
  final String taskId;
  final String taskTitle;
  final String taskDescription;
  final String taskWorkspaceName;
  final bool taskIsCompleted;

  HomeTaskCard({this.taskId, this.taskTitle, this.taskDescription, this.taskWorkspaceName, this.taskIsCompleted});

  @override
  _HomeTaskCardState createState() => _HomeTaskCardState();
}

class _HomeTaskCardState extends State<HomeTaskCard> {



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Container(
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text(
                  widget.taskWorkspaceName,
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.caption.color,
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
                (widget.taskDescription != null)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                        child: Text(
                          widget.taskDescription,
                          style: TextStyle(
                            fontSize: 12.0,
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
                      onPressed: () {
                        Firestore.instance.collection('tasks').document(widget.taskId).updateData({
                          'isCompleted': !widget.taskIsCompleted
                        });
                      },
                      icon: (widget.taskIsCompleted) ? Icon(Icons.check_circle) : Icon(Icons.check_circle_outline),
                      color: (widget.taskIsCompleted) ? Theme.of(context).accentColor : Colors.grey,
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
