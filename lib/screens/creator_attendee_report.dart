import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../requests/creator_export_attendee_report.dart';
import '../requests/creator_get_dashboard.dart';
import '../widgets/loading_indicator.dart';

class CreatorAttendeeReport extends StatelessWidget {
  static const routeName = '/creator-attendee-report';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendee Summary'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'report') {
                await creatorExportAttendeeReport(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                  value: 'report',
                  child: Row(
                    children: [
                      Icon(Icons.download_outlined),
                      Text('Download Attendee Report',
                          style: TextStyle(fontSize: 16)),
                    ],
                  )),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
          future: getAttendeeReport(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingIndicator();
            } else if (snapshot.data != null &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                                'Order Number: ${snapshot.data[index].orderNumber}'),
                            SizedBox(height: 8),
                            Text(
                                'Order Date: ${DateFormat.yMd().add_jm().format(snapshot.data[index].orderDate)}'),
                            SizedBox(height: 8),
                            Text(
                                'Ticket Type: ${snapshot.data[index].ticketType}'),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('No data found!'),
              );
            }
          }),
    );
  }
}
