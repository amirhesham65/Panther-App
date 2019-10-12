import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
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
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
