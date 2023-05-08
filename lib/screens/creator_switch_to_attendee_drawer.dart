import 'package:flutter/material.dart';

import '../requests/switch_to_attendee_api.dart';
import 'tabs_screen.dart';

class CreatorSwitchToAttendeeDrawer extends StatelessWidget {
  static const routeName = '/creatorDrawer';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Switch to Attendee'),
            onTap: () async {
              int result = await switchtoAttendee(context);
              if (result == 0) {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
