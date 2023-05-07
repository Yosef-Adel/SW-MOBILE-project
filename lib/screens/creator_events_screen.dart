///This screen displays the events created by a certain user who is a creator.
///The events are categorized into All, Upcoming and Past. The user can also add a new event from this screen.
///The screen contains a drawer which allows the user to navigate to other screens.

import 'package:envie_cross_platform/widgets/creator_events_list_widget.dart';
import 'package:flutter/material.dart';
import 'event_creation_basic_info_screen.dart';

import 'creator_drawer.dart';

class CreatorEvents extends StatelessWidget {
  const CreatorEvents({super.key});

  static const routeName = '/creator-events';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(EventBasicInfo.routeName);
          },
        ),
        drawer: CreatorDrawer(),
        appBar: AppBar(
          title: Text('Events'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                CreatorEventsList(choice: 0),
                CreatorEventsList(choice: 1),
                CreatorEventsList(choice: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
