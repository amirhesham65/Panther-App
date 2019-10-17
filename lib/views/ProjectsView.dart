import 'package:flutter/material.dart';

// The listing projects view
class ProjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Projects'),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
            child: CircleAvatar(
              child: Text('A'),
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
                      leading: CircleAvatar(
                        child: Text('Q'),
                      ),
                      title: Text('Quak'),
                      subtitle: Text('12 Sep | 3 Members'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('R'),
                      ),
                      title: Text('Rubium Studio'),
                      subtitle: Text('15 Sep | 2 Members'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('P'),
                      ),
                      title: Text('Panther App'),
                      subtitle: Text('29 Nov | 1 Members'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
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