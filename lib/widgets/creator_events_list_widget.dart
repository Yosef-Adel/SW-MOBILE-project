import 'package:envie_cross_platform/widgets/creator_event_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../requests/creator_export_events.dart';
import '../requests/creator_get_events_api.dart';
import 'loading_indicator.dart';

class CreatorEventsList extends StatelessWidget {
  int choice;
  CreatorEventsList({required this.choice});

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
                        eventId: snapshot.data[index].id,
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
                if (choice == 0)
                  FloatingActionButton.extended(
                    heroTag: "CSV Export Button",
                    onPressed: () async => creatorExportEvents(context),
                    label: Text('CSV Export'),
                    icon: Icon(Icons.download),
                    backgroundColor: Theme.of(context).primaryColor,
                  )
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
