import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panther_app/models/task.dart';
import 'package:panther_app/services/database.dart';
import 'package:panther_app/views/EditTask.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SingleTaskView extends StatefulWidget {
  final Task task;

  SingleTaskView({this.task});

  @override
  _SingleTaskViewState createState() => _SingleTaskViewState();
}

// Showing Add Task View
void showEditTaskView(BuildContext context, DocumentSnapshot task) {
  Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.downToUp,
      child: EditTask(task: task),
    ),
  );
}

class _SingleTaskViewState extends State<SingleTaskView> {
  // Show delete task alert dialog
  Future<void> _openDeleteTaskDialogAlert(String taskId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you want to delete this task?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You can\'t undo this action. Are you sure you want to delete this task?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pop(context);
                // Deleted a task
                Future.delayed(Duration(milliseconds: 500), () {
                  databaseService.deleteTask(taskId);
                });
              },
            ),
          ],
        );
      },
    );
  }

  String subtaskText = "";

  // Sub-task addding bottom-sheet
  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Add a new Sub-task'),
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        subtaskText = value;
                      });
                    },
                    onSubmitted: (value) {
                      addSubTask(subtaskText, false);
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          addSubTask(subtaskText, false);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  List subTasks = [];


  // Below are the operations on subtasks are added here because the intract 
  // directly With the Flutter framework (I needed to use setState() function, etc)

  // Getting the subtasks of the task
  Future<void> getSubTasks() async {
    DocumentSnapshot taskSnapshot = await Firestore.instance
        .collection('tasks')
        .document(widget.task.reference.documentID)
        .get();
    if (taskSnapshot.data['subtasks'] != null) {
      setState(() {
        subTasks = taskSnapshot.data['subtasks'].toList();
      });
    }
  }

  // Setting the subtasks of the task
  Future<void> setSubTasks() async {
    await Firestore.instance
        .collection('tasks')
        .document(widget.task.reference.documentID)
        .updateData({'subtasks': subTasks});
  }

  // Adding a new subtask
  Future<void> addSubTask(String title, bool isCompleted) async {
    subTasks.add({
      'title': title,
      'isCompleted': isCompleted,
      'timeCreated': new DateTime.now()
    });
    await setSubTasks();
  }

  // Deleting a subtask
  Future<void> deleteSubTask(subtask) async {
    await getSubTasks();
    List newSubTasks = subTasks
        .where((sub) => sub['timeCreated'] != subtask['timeCreated'])
        .toList();
    setState(() {
      subTasks = newSubTasks;
    });
    await setSubTasks();
  }

  Future<void> completeSubTask(subtask) async {
    await getSubTasks();
    List newSubTasks = subTasks
        .where((sub) => sub['timeCreated'] != subtask['timeCreated'])
        .toList();
    setState(() {
      subTasks = newSubTasks;
    });
    subTasks.add({
      'title': subtask['title'],
      'isCompleted': !subtask['isCompleted'],
      'timeCreated': new DateTime.now()
    });
    await setSubTasks();
  }

  // Handling reorder
  Future<void> onReorder(int oldIndex, int newIndex) async {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      var movedSubTask = subTasks.removeAt(oldIndex);
      subTasks.insert(newIndex, movedSubTask);
    });
    await setSubTasks();
  }

  @override
  void initState() {
    super.initState();
    // Getting the subtasks
    getSubTasks();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseService.getTaskById(widget.task.reference.documentID),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Lodaing');
        }
        // The task and its subtasks
        DocumentSnapshot task = snapshot.data;
        List fetchedSubTasks = task['subtasks'];
        return Scaffold(
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            actions: <Widget>[
              IconButton(
                onPressed: _modalBottomSheetMenu,
                icon: Icon(Icons.playlist_add),
              ),
              IconButton(
                onPressed: () => showEditTaskView(context, task),
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => _openDeleteTaskDialogAlert(
                  widget.task.reference.documentID,
                ),
                icon: Icon(Icons.delete),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: LinearProgressIndicator(
                value: 0.5,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                                letterSpacing: 0.3,
                                decoration: (task['isCompleted'])
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
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
                                      decoration: (task['isCompleted'])
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
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
                            stream: databaseService
                                .streamUser(task['userAssignedId']),
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
                                            : Text(taskUser['displayName'][0]),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Text(
                  'Sub-tasks',
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              (fetchedSubTasks.length > 0)
                  ? Expanded(
                      child: ReorderableListView(
                        onReorder: onReorder,
                        children: fetchedSubTasks
                            .map(
                              (subtask) => Dismissible(
                                key: ValueKey(subtask),
                                onDismissed: (direction) async =>
                                    await deleteSubTask(subtask),
                                background: Container(color: Colors.redAccent),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  key: ValueKey(subtask),
                                  title: Text(subtask['title']),
                                  leading: IconButton(
                                    onPressed: () async =>
                                        await completeSubTask(subtask),
                                    icon: (subtask['isCompleted'] == true)
                                        ? Icon(Icons.check_circle)
                                        : Icon(Icons.check_circle_outline),
                                  ),
                                  trailing: Icon(Icons.reorder),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
