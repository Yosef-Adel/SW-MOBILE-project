import 'package:envie_cross_platform/screens/creator_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:envie_cross_platform/screens/creator_dashboard.dart';
import 'package:envie_cross_platform/screens/creator_manage_attendees.dart';
import 'package:envie_cross_platform/screens/creator_publish.dart';
import 'package:envie_cross_platform/screens/creator_tickets.dart';
import 'package:envie_cross_platform/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/user_provider.dart';
import '../requests/routes_api.dart';
import 'dart:convert';

class CreatorDrawer extends StatelessWidget {
  static const routeName = '/creatorDrawer';

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    var token = Provider.of<UserProvider>(context, listen: false).token;
    final userID = userProv.user.id;
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Creator\'s View'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Events'),
            onTap: () {
              //print(userID);
              //print(token);
              Navigator.of(context)
                  .pushReplacementNamed(CreatorEvents.routeName);
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
            onTap: () async {
              //print(userID);
              final url = Uri.parse('${RoutesAPI.changeToAttendee}/$userID');
              //print(url);
              //print(token);
              final headers = {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token'
              };
              final response = await http.get(
                url,
                headers: headers,
              );
              final jsonResponse = json.decode(response.body);
              final message = jsonResponse['message'];
              //print(message);
              if (message ==
                  "Your token is invalid, your are not authorized!") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You are not authorized'),
                  ),
                );
              } else {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              }
            },
            //Navigator.pushNamed(context, TabsScreen.routeName);
          ),
        ],
      ),
    );
  }
}
