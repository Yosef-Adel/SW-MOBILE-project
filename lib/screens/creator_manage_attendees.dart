import 'package:flutter/material.dart';
import 'creator_drawer.dart';

class CreatorManageAttendees extends StatelessWidget {
  static const routeName = '/creatorManageAttendees';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Attendees'),
      ),
      drawer: CreatorDrawer(),
      body: Container(),
    );
  }
}
