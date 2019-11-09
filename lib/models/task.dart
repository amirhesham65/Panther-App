import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String title;
  String description;
  String workspaceId;
  String workspaceName;
  bool isCompleted;
  DateTime schedule;

  // The document reference will be set to snapshot reference
  DocumentReference reference;

  // Formatting the task data f
  Task.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null && map['workspaceId'] != null),
        title = map['title'],
        workspaceId = map['workspaceId'],
        workspaceName = map['workspaceName'],
        description = map['description'],
        isCompleted = map['isCompleted'];

  // Formatting the snapshot data
  Task.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Task<$title:$description>";
}
