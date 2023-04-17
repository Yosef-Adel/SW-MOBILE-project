import 'package:flutter/material.dart';
import 'creator_drawer.dart';

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
