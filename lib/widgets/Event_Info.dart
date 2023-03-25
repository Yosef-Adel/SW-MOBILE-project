import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:envie_cross_platform/models/event.dart';

class EventInfo extends StatelessWidget {
  final String dateTime;
  final String location;
  final String Duration;
  final String Price;
  final String StartAt;
  final bool isOnline;
  final bool isFree;
  final String summary;

  EventInfo(this.dateTime, this.location, this.Duration, this.Price,
      this.StartAt, this.isOnline, this.isFree, this.summary);

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
              "Duration: ${Duration}",
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
                  '\$${Price}',
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