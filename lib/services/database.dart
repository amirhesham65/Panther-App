import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panther_app/models/user.dart';

class DatabaseService {
  // Adding a user to the DB directly
  Future<User> _addUserToDatabase(User currentUser) async {
    await Firestore.instance
        .collection('users')
        .document(currentUser.id)
        .setData({
      'id': currentUser.id,
      'displayName': currentUser.displayName,
      'email': currentUser.email,
      'photoUrl': currentUser.photoUrl
    });
    return currentUser;
  }

  // Getting a certain user by his Id
  dynamic getUserById(String userId) async {
    DocumentSnapshot userSnapshot =
        await Firestore.instance.collection('users').document(userId).get();
    return userSnapshot.data;
  }

  // Stream user data by his id
  Stream<DocumentSnapshot> streamUser(String userId) {
    return Firestore.instance.collection('users').document(userId).snapshots();
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
      {User user,
      String taskTitle,
      String taskDescription,
      String workspaceId,
      DateTime schedule,
      String assignedUserId}) async {
    assert(taskTitle != null);
    await Firestore.instance.collection('tasks').document().setData({
      'workspaceId': workspaceId,
      'workspaceName': (await getWorkspaceById(workspaceId))['name'],
      'title': taskTitle,
      'description': taskDescription,
      'isCompleted': false,
      'schedule': schedule,
      'userAssignedId': assignedUserId
    });
  }

  // Deleteing a task
  Future<void> deleteTask(String taskId) async {
    await Firestore.instance.collection('tasks').document(taskId).delete();
  }

  // Streaming the user's workspaces
  Stream<QuerySnapshot> getUsersWorkspaces(User currentUser) {
    return Firestore.instance
        .collection('workspaces')
        .where('users', arrayContains: currentUser.id)
        .snapshots();
  }

  // Streaming workspace tasks
  Stream<QuerySnapshot> getWorkspaceTasks(String workspaceId) {
    return Firestore.instance
          .collection('tasks')
          .where('workspaceId', isEqualTo: workspaceId)
          .snapshots();
  }

  // Getting a task by its Id
  Stream<DocumentSnapshot> getTaskById(String taskId) {
    assert(taskId != null);
    return Firestore.instance.collection('tasks').document(taskId).snapshots();
  }

  // Streaming the user's tasks
  Stream<QuerySnapshot> getUsersTasks(User currentUser) {
    return Firestore.instance
        .collection('tasks')
        .where('userAssignedId', isEqualTo: currentUser.id)
        .snapshots();
  }

  // Getting the users in the workspace
  Stream<QuerySnapshot> getWorkspaceUsers(String workspaceId) {
    assert(workspaceId != null);
    return Firestore.instance
        .collection('users')
        .where('workspaces', arrayContains: workspaceId)
        .snapshots();
  }

  // Returnning workspace data by id
  Future<Map> getWorkspaceById(String id) async {
    DocumentSnapshot snapshot =
        await Firestore.instance.collection('workspaces').document(id).get();
    return snapshot.data;
  }

  // Add user to the workspace
  Future<void> addUserToWorkspace(
      {User currentUser, String workspaceId}) async {
    DocumentReference workspaceReference =
        Firestore.instance.collection('workspaces').document(workspaceId);
    workspaceReference
        .collection('workspaceUsers')
        .add({'date': new DateTime.now(), 'userId': currentUser.id});
  }

  // Add workspace to user
  Future<void> addWorkspaceToUser(
      {User currentUser, String workspaceId}) async {
    DocumentReference userReference =
        Firestore.instance.collection('users').document(currentUser.id);
    userReference.updateData({
      'workspaces': FieldValue.arrayUnion([workspaceId])
    });
  }

  // Creating a new workspace
  Future<void> createWorkspace(
      {User currentUser,
      String workspaceName,
      String workspaceDescription}) async {
    assert(workspaceName != null);
    final DocumentReference newWorkspace =
        await Firestore.instance.collection('workspaces').add({
      'name': workspaceName,
      'description': workspaceDescription,
      'users': [currentUser.id]
    });
    // Adding workspace id to the user
    await addWorkspaceToUser(
      currentUser: currentUser,
      workspaceId: newWorkspace.documentID,
    );
  }

  // Toggle task isCompleted status
  Future<void> completeTask(String taskId, bool isCompleted) async {
    await Firestore.instance
        .collection('tasks')
        .document(taskId)
        .updateData({'isCompleted': !isCompleted});
  }

  //
}

DatabaseService databaseService = DatabaseService();
