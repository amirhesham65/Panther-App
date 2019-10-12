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
          Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0), child: CircleAvatar(child: Text('A'),),)
        ],
      ),
      drawer: Drawer(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              child: Text(
                'Today\'s tasks',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.caption.color,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            // Listing all today's tasks
          Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              TaskCard(),
              TaskCard()
            ],
          ),
        ),
          ],
        ),
      )
    );
  }
}
