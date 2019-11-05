import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panther_app/models/user.dart';

class DatabaseService {
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
      'users': [currentUser.email],
      'name': workspaceName,
      'description': workspaceDescription,
    });
  }

  // Adding a user to the DB directly
  Future<User> _addUserToDatabase(User currentUser) async {
    await Firestore.instance.collection('users').document().setData({
      'googleId': currentUser.id,
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
}

DatabaseService databaseService = DatabaseService();
