import 'package:envie_cross_platform/widgets/creator_event_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../requests/creator_export_events.dart';
import '../requests/creator_get_events_api.dart';
import 'loading_indicator.dart';

class CreatorEventsList extends StatelessWidget {
  int choice;
  CreatorEventsList({required this.choice});

  void selectEvent(BuildContext ctx, Event e) {
    //Navigator.of(ctx).pushNamed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: creatorGetEvents(context, choice),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          } else if (snapshot.data != null &&
              snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx, index) {
                      return CreatorEventCard(
                        title: snapshot.data[index].title,
                        date: DateFormat('dd/MM/yyyy')
                            .format(snapshot.data[index].startDate),
                        soldTickets:
                            snapshot.data[index].soldTickets.toString(),
                        totalTickets:
                            snapshot.data[index].totalTickets.toString(),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                ),
                choice == 0
                    ? FloatingActionButton.extended(
                        onPressed: () async => creatorExportEvents(context),
                        label: Text('CSV Export'),
                        icon: Icon(Icons.download),
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    : SizedBox(height: 0),
              ],
            );
          } else {
            return Column(
              children: [
                SizedBox(height: 20),
                Text('No events found!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            );
          }
        });
  }
}
