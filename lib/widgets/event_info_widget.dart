///This widget is used to display the event details on the event screen.

import 'package:flutter/material.dart';

class EventInfo extends StatelessWidget {
  final String dateTime;
  final String location;
  final String duration;
  final String price;
  final String startAt;
  final bool isOnline;
  final bool isFree;
  final String summary;

  EventInfo(
      {required this.dateTime,
      required this.location,
      this.duration = "",
      required this.price,
      required this.startAt,
      required this.isOnline,
      this.isFree = false,
      required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            child: Icon(Icons.calendar_today),
          ),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateTime,
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 24, 24, 24)),
                ),
                //   Text('Starts at ${StartAt}',
                //       style: TextStyle(
                //           fontSize: 15, color: Color.fromARGB(255, 104, 104, 104))),
                // ],
              ]),
        ),
        isOnline
            ? ListTile(
                leading: Container(
                  child: Icon(Icons.play_circle),
                ),
                title: Text(
                  "Online",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 24, 24, 24)),
                ))
            : ListTile(
                leading: Container(
                  child: Icon(Icons.location_pin),
                ),
                title: Text(
                  location,
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 24, 24, 24)),
                )),
        ListTile(
            leading: Container(
              child: Icon(Icons.timelapse_outlined),
            ),
            title: Text(
              "Duration: ${duration}",
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 24, 24, 24)),
            )),
        isFree
            ? ListTile(
                leading: Container(
                  child: Icon(Icons.confirmation_num_outlined),
                ),
                title: Text(
                  'Free',
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 24, 24, 24)),
                ),
                subtitle: Text(
                  "On Envie",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 104, 104, 104)),
                ))
            : ListTile(
                leading: Container(
                  child: Icon(Icons.confirmation_num_outlined),
                ),
                title: Text(
                  '\$${price}',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 24, 24, 24)),
                ),
                subtitle: Text(
                  "On Envie",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 104, 104, 104)),
                ),
              ),
        Center(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              'About',
              style:
                  TextStyle(fontFamily: 'Nexa', fontSize: 30, height: 1.0005),
            ),
          ),
        ),
        Center(
            child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            summary,
            style: TextStyle(fontSize: 13, height: 1.1),
          ),
        ))
      ],
    );
  }
}
