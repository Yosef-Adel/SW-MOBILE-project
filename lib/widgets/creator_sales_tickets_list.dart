import 'package:flutter/material.dart';

import '../requests/creator_get_dashboard.dart';
import 'loading_indicator.dart';

class CreatorSalesTicketsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchTicketsSales(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          } else if (snapshot.data != null &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data['ticketType'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Price: ${snapshot.data['Price'].toString()}'),
                            Text('Sold: ${snapshot.data['sold'].toString()}'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Total: ${snapshot.data['total'].toString()}'),
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: Text('No data found!'),
            );
          }
        });
  }
}
