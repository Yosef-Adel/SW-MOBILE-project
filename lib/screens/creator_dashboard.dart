import 'package:flutter/material.dart';
import 'creator_drawer.dart';

class CreatorDashboard extends StatelessWidget {
  static const routeName = '/creatorDashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: CreatorDrawer(),
      body: Container(),
    );
  }
}
