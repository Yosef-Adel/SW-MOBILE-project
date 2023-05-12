import 'package:flutter/material.dart';

import '../requests/creator_get_dashboard.dart';

class CreatorSalesTicketsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchTicketsSales(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
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
                            snapshot.data[index].ticketType,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                      'Price: ${snapshot.data[index].price.toString()}')),
                              Expanded(
                                  child: Text(
                                      'Sold: ${snapshot.data[index].sold.toString()}')),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                              'Total: ${snapshot.data[index].total.toString()}'),
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
        });
  }
}
