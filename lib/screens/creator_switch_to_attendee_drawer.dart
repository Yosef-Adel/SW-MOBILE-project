import 'package:flutter/material.dart';

import '../requests/switch_to_attendee_api.dart';
import 'creator_show_basic_info.dart';

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
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outlined),
            title: Text('Switch to Attendee'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CreatorShowBasicInfo.routeName);
            },
          ),
        ],
      ),
    );
  }
}
