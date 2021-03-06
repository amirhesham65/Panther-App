import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/models/workspace.dart';
import 'package:panther_app/services/database.dart';
import 'package:panther_app/views/AddWorkspace.dart';
import 'package:provider/provider.dart';

// Showing Add workspace View
void showAddWorkspaceView(BuildContext context) {
  Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.downToUp,
      child: AddWorkspace(),
    ),
  );
}

// The listing projects view
class WorkspacesView extends StatelessWidget {
  
  // Getting data from Firebase Firestore
  Widget _buildListBody(BuildContext context) {
    final User currentUser = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: databaseService.getUsersWorkspaces(currentUser),
      // The stream gets the data and the builder process that data
      builder: (context, snapshots) {
        // Check if the snapshot has data
        if (!snapshots.hasData) return LinearProgressIndicator();
        // Build the actual task list
        return _buildWorkspacesList(context, snapshots.data.documents);
      },
    );
  }

  // Building the actual workspace list
  Widget _buildWorkspacesList(
      BuildContext context, List<DocumentSnapshot> snapshots) {
    return ListView(
      children: snapshots
          .map((snapshot) => _buildWorkspacesListItem(context, snapshot))
          .toList(),
    );
  }

  // Building each workspace list item
  Widget _buildWorkspacesListItem(
      BuildContext context, DocumentSnapshot snapshot) {
    final Workspace workspace = Workspace.fromSnapshot(snapshot);
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/workspace',
          arguments: workspace,
        );
      },
      leading: CircleAvatar(
        child: Text(workspace.name[0]),
      ),
      title: Text(workspace.name),
      subtitle: Text('0 updates'),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.reorder),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workspaces'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black26
            : Colors.white,
        actions: <Widget>[
          FlatButton(
            onPressed: () => showAddWorkspaceView(context),
            child: Text(
              'Create',
              style: TextStyle(color: Colors.orange),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[Expanded(child: _buildListBody(context))],
        ),
      ),
    );
  }
}
