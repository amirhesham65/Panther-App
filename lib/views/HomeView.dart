import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panther_app/components/task_card.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Today'),
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
        drawer: _AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: Text(
                  'Today\'s tasks',
                  style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.caption.color,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // Listing all today's tasks
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 200.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    TaskCard(
                      projectName: 'Rubium Studio',
                      taskTitle: 'Build the landing page',
                      taskDescription:
                          'Maybe you’ve got an idea in mind already a book you’d really love to write.',
                    ),
                    TaskCard(
                      projectName: 'Quak',
                      taskTitle: 'Rebuild the MVP',
                      taskDescription:
                          'Ask your audience what they want, and give them a few possibilities to choose from.',
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Text(
                  'Recent projects',
                  style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.caption.color,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(child: Text('Q'),),
                      title: Text('Quak'),
                      subtitle: Text('12 Sep | 3 Members'),
                      trailing: Icon(Icons.check_circle_outline),
                    ),
                    ListTile(
                      leading: CircleAvatar(child: Text('R'),),
                      title: Text('Rubium Studio'),
                      subtitle: Text('15 Sep | 2 Members'),
                      trailing: Icon(Icons.check_circle_outline),
                    ),
                    ListTile(
                      leading: CircleAvatar(child: Text('Q'),),
                      title: Text('Panther App'),
                      subtitle: Text('29 Nov | 1 Members'),
                      trailing: Icon(Icons.check_circle_outline),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// The app side drawer
class _AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Amir Hesham'),
              accountEmail: Text('amirhesham65@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: Text('A'),
              ),
            ),
            ListTile(
              title: Text('Today'),
              trailing: Icon(Icons.today),
            ),
            ListTile(
              title: Text('Projects'),
              trailing: Icon(Icons.view_carousel),
            ),
            ListTile(
              title: Text('Personal'),
              trailing: Icon(Icons.person),
            ),
            Divider(),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(Icons.settings),
            ),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Transform.scale(
                scale: 0.9,
                child: CupertinoSwitch(
                  value: true,
                  onChanged: (bool isEnabled) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
