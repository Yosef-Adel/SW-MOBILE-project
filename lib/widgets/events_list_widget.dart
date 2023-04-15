///This widget is used to display the list of events on the events screen.
///It is a stateless widget because it does not need to maintain any state.
///It is a list view builder because it needs to display a list of event cards.

import 'package:envie_cross_platform/requests/get_all_events_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../screens/event_screen.dart';
import 'loading_indicator.dart';

class EventsList extends StatelessWidget {
  void selectEvent(BuildContext ctx, Event e) {
    Navigator.of(ctx).pushNamed(
      EventScreen.routeName,
      arguments: e,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllEvents(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index) {
                return Container(
                  height: 100,
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: () => selectEvent(ctx, snapshot.data[index]),
                      leading: Container(
                        width: 80,
                        height: 110,
                        child: AspectRatio(
                          aspectRatio: 0.5,
                          child: Image.network(
                            snapshot.data[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text(
                              DateFormat("d MMM yyyy")
                                  .add_jm()
                                  .format(snapshot.data[index].startDate),
                              style: TextStyle(
                                  //color: Color(0xFFD1410C),
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(snapshot.data[index].title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Bebas',
                              )),
                          Container(
                            child: Text(snapshot.data[index].venueName,
                                style: TextStyle(
                                  color: Color.fromRGBO(72, 72, 72, 0.5),
                                  fontSize: 10,
                                )),
                          ),
                          Row(
                            children: [
                              Icon(Icons.person_2_outlined, size: 15),
                              Text('3100 creator followers',
                                  style: TextStyle(fontSize: 10)),
                              SizedBox(width: 75),
                              Row(
                                children: [
                                  Icon(Icons.upload_outlined, size: 15),
                                  Icon(Icons.favorite_outlined, size: 15),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.length,
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        });
  }
}
