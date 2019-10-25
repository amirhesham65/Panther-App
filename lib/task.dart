import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String title;
  String description;
  // The document reference will be set to snapshot reference
  DocumentReference reference;

  // Formatting the task data f
  Task.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['description'] != null),
        title = map['title'],
        description = map['description'];

  // Formatting the snapshot data
  Task.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Task<$title:$description>";
}
