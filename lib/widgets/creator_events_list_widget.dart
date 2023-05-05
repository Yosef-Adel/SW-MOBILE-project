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
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: EdgeInsets.only(bottom: 150),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx, index) {
                      return Container(
                        height: 100,
                        child: Card(
                          elevation: 0,
                          child: ListTile(
                            //onTap: () => selectEvent(ctx, snapshot.data[index])
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(snapshot.data[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Bebas',
                                    )),
                                Text(
                                  DateFormat("d MMM yyyy")
                                      .add_jm()
                                      .format(snapshot.data[index].startDate),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                  ),
                                ),
                                // Text(
                                //   '${snapshot.data[index].description}/${snapshot.data[index].description}',
                                //   style: TextStyle(
                                //     color: Colors.black,
                                //     fontSize: 11,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                ),
                (choice == 0)
                    ? FloatingActionButton(
                        onPressed: () async => creatorExportEvents(context),
                        child: Icon(Icons.file_download),
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    : SizedBox(height: 20),
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
                SizedBox(height: 20),
              ],
            );
          }
        });
  }
}
