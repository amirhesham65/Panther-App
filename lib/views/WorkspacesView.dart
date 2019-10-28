import 'package:flutter/material.dart';

// The listing projects view
class WorkspacesView extends StatelessWidget {
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
            onPressed: () {},
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
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/workspace',
                        arguments: {'name': 'Quak'},
                      );
                    },
                    leading: CircleAvatar(
                      child: Text('Q'),
                    ),
                    title: Text('Quak'),
                    subtitle: Text('8 updates'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.reorder),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('R'),
                    ),
                    title: Text('Rubium Studio'),
                    subtitle: Text('2 updates'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.reorder),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('P'),
                    ),
                    title: Text('Panther App'),
                    subtitle: Text('2 updates'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.reorder),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
