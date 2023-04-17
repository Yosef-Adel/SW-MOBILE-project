import 'package:envie_cross_platform/screens/creator_dashboard.dart';
import 'package:envie_cross_platform/screens/creator_manage_attendees.dart';
import 'package:envie_cross_platform/screens/creator_publish.dart';
import 'package:envie_cross_platform/screens/creator_tickets.dart';
import 'package:envie_cross_platform/screens/creator_view.dart';
import 'package:envie_cross_platform/screens/tabs_screen.dart';

import 'package:flutter/material.dart';

class CreatorDrawer extends StatelessWidget {
  static const routeName = '/creatorDrawer';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Creator\'s View'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Basic Info'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CreatorView.routeName);
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
            leading: Icon(Icons.confirmation_num_outlined),
            title: Text('Tickets'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CreatorTickets.routeName);
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
            leading: Icon(Icons.border_color_outlined),
            title: Text('Publish'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CreatorPublish.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Back to Home Page'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, TabsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class CreatorTickets extends StatelessWidget {
  static const routeName = '/creatorTickets';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creator Tickets'),
      ),
      drawer: CreatorDrawer(),
      body: Container(),
    );
  }
}

class CreatorView extends StatelessWidget {
  static const routeName = '/creatorView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creator View'),
      ),
      drawer: CreatorDrawer(),
      body: Container(),
    );
  }
}
