import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panther_app/models/user.dart';

class DatabaseService {
  // Adding a user to the DB directly
  Future<User> _addUserToDatabase(User currentUser) async {
    await Firestore.instance.collection('users').document().setData({
      'id': currentUser.id,
      'displayName': currentUser.displayName,
      'email': currentUser.email,
      'photoUrl': currentUser.photoUrl
    });
    return currentUser;
  }

  // Creating the user [MAIN]
  Future<User> createUser(User currentUser) async {
    // Check if the Google user object was fetched
    if (currentUser != null) {
      // Check if the user was already in Firestore DB
      Firestore.instance
          .collection('users')
          .where('email', isEqualTo: currentUser.email)
          .snapshots()
          .listen((data) async {
        if (data.documents.length == 0) {
          // Add the user to database
          await _addUserToDatabase(currentUser);
        }
      });
    }
    return currentUser;
  }

  // Adding a new task to the Cloud FireStore
  Future<void> createTask(
      {String taskTitle, String taskDescription, String workspaceId}) async {
    assert(taskTitle != null);
    await Firestore.instance.collection('tasks').document().setData({
      'workspaceId': workspaceId,
      'workspaceName': (await getWorkspaceById(workspaceId))['name'],
      'title': taskTitle,
      'description': taskDescription,
      'isCompleted': false
    });
  }

  // Streaming the user's workspaces
  Stream<QuerySnapshot> getUsersWorkspaces(User currentUser) {
    return Firestore.instance
        .collection('workspaces')
        .where('users', arrayContains: currentUser.id)
        .snapshots();
  }

  // Returnning workspace data by id
  Future<Map> getWorkspaceById(String id) async {
    DocumentSnapshot snapshot =
        await Firestore.instance.collection('workspaces').document(id).get();
    return snapshot.data;
  }

  // Adding workspace to the user
  Future<void> createWorkspace(
      {User currentUser,
      String workspaceName,
      String workspaceDescription}) async {
    assert(workspaceName != null);
    return await Firestore.instance
        .collection('workspaces')
        .document()
        .setData({
      'users': [currentUser.id],
      'name': workspaceName,
      'description': workspaceDescription,
    });
  }

  // Toggle task isCompleted status
  Future<void> completeTask(String taskId, bool isCompleted) async {
    await Firestore.instance
        .collection('tasks')
        .document(taskId)
        .updateData({'isCompleted': !isCompleted});
  }
}

DatabaseService databaseService = DatabaseService();
