import 'package:envie_cross_platform/screens/creator_dashboard.dart';
import 'package:envie_cross_platform/screens/creator_events_screen.dart';
import 'package:envie_cross_platform/screens/creator_publish.dart';
import 'package:envie_cross_platform/screens/creator_tickets.dart';
import 'package:flutter/material.dart';

import '../requests/switch_to_attendee_api.dart';
import 'creator_show_basic_info.dart';
import 'manage_attendees_screen.dart';
import 'tabs_screen.dart';
import 'manage_attendees_screen.dart';

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
              Navigator.pushNamed(context, ManageAttendees.routeName);
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
              leading: Icon(Icons.event_outlined),
              title: Text('Events'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, CreatorEvents.routeName);
              }),
        ],
      ),
    );
  }
}
