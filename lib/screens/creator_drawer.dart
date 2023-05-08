import 'package:envie_cross_platform/screens/creator_dashboard.dart';
import 'package:envie_cross_platform/screens/creator_manage_attendees.dart';
import 'package:envie_cross_platform/screens/creator_publish.dart';
import 'package:envie_cross_platform/screens/creator_tickets.dart';
import 'package:flutter/material.dart';

import '../requests/switch_to_attendee_api.dart';
import 'creator_show_basic_info.dart';

class CreatorDrawer extends StatelessWidget {
  static const routeName = '/creatorDrawer';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            //title: Text('Creator\'s View'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outlined),
            title: Text('Basic Info'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CreatorShowBasicInfo.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.confirmation_num_outlined),
            title: Text('Tickets'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CreatorTickets.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.border_color_outlined),
            title: Text('Publish'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CreatorPublish.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.admin_panel_settings_outlined),
            title: Text('Manage Attendees'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CreatorManageAttendees.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.assessment_outlined),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CreatorDashboard.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Back to Home Page'),
            onTap: () async => switchtoAttendee(context),
            //Navigator.pushNamed(context, TabsScreen.routeName);
          ),
        ],
      ),
    );
  }
}
