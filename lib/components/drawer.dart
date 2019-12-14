import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panther_app/models/user.dart';
import 'package:panther_app/views/WelcomeView.dart';
import 'package:provider/provider.dart';

// The app side drawer
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting the current user from the Provider
    User user = Provider.of<User>(context);

    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.6),
                child: (user.photoUrl != null)
                    ? ClipOval(child: Image.network(user.photoUrl))
                    : Text(user.displayName[0]),
              ),
            ),
            ListTile(
              title: Text('Today'),
              trailing: Icon(Icons.today),
            ),
            ListTile(
              title: Text('Workspaces'),
              trailing: Icon(Icons.view_carousel),
              onTap: () => Navigator.pushNamed(context, '/workspaces'),
            ),
            Divider(),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(Icons.settings),
            ),
            ListTile(
              title: Text('SignOut'),
              trailing: Icon(Icons.settings),
              onTap: () {
                auth.handleSignOutFromGoogle();
              },
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
