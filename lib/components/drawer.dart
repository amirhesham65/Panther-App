import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// The app side drawer
class AppDrawer extends StatelessWidget {
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
              onTap: () => Navigator.pushNamed(context, '/projects')
            ),
            ListTile(
              title: Text('Personal'),
              trailing: Icon(Icons.person),
              onTap: () => Navigator.pushNamed(context, '/personal')
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