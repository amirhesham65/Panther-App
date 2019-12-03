import 'package:flutter/material.dart';
import 'package:panther_app/models/task.dart';
import 'package:panther_app/services/database.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SingleTaskView extends StatefulWidget {
  final Task task;

  SingleTaskView({this.task});

  @override
  _SingleTaskViewState createState() => _SingleTaskViewState();
}

class _SingleTaskViewState extends State<SingleTaskView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseService.getTaskById(widget.task.reference.documentID),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Lodaing');
        }
        var task = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.playlist_add),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              )
            ],
          ),
          body: SingleChildScrollView(
                child: Hero(
                  tag: 'task_' + widget.task.reference.documentID,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Text(
                            task['workspaceName'],
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .caption
                                  .color,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            task['title'],
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3),
                          ),
                          (task['description'] != null)
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 8.0, 0.0, 0.0),
                                  child: Text(
                                    task['description'],
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
                                    widget.task.reference.documentID,
                                    task['isCompleted']),
                                icon: (task['isCompleted'])
                                    ? Icon(Icons.check_circle)
                                    : Icon(Icons.check_circle_outline),
                                color: (task['isCompleted'])
                                    ? Theme.of(context).accentColor
                                    : Colors.grey,
                              ),
                            ],
                          ),
                          StreamBuilder(
                            stream: databaseService.streamUser(task['userAssignedId']),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return Text('Loading');
                              var taskUser = snapshot.data;
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0.0),
                                      leading: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.6),
                                        child: (taskUser['photoUrl'] != null)
                                            ? ClipOval(
                                                child: Image.network(
                                                  taskUser['photoUrl'],
                                                  width: 35.0,
                                                ),
                                              )
                                            : Text(task['displayName'][0]),
                                      ),
                                      title: Text('Assigned to'),
                                      subtitle: Text(taskUser['displayName']),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        );
      },
    );
  }
}
