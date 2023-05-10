import 'package:flutter/material.dart';

import '../requests/creator_get_dashboard.dart';
import '../widgets/loading_indicator.dart';

class CreatorAttendeeReport extends StatelessWidget {
  static const routeName = '/creator-attendee-report';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendee Summary'),
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
                            Text('Price: ${snapshot.data[index].orderNumber}'),
                            SizedBox(height: 8),
                            Text(
                                'Sold: ${snapshot.data[index].orderDate.toString()}'),
                            SizedBox(height: 8),
                            Text('Total: ${snapshot.data[index].ticketType}'),
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
