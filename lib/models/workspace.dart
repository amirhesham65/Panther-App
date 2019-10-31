import 'package:cloud_firestore/cloud_firestore.dart';

class Workspace {
  String name;
  int number;
  // The document reference will be set to snapshot reference
  DocumentReference reference;

  // Formatting the Workspace data f
  Workspace.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'],
        number = map['number'];

  // Formatting the snapshot data
  Workspace.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Workspace<$name:$number>";
}
