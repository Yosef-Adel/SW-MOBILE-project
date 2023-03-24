import 'package:intl/intl.dart';

import '../models/event.dart';
import 'package:flutter/material.dart';
import 'package:envie_cross_platform/widgets/Event_info.dart';

class EventPage extends StatelessWidget {
  //final String id;
  //final String appBarText;
  static const routeName = '/event-Details';

  @override
  Widget build(BuildContext context) {
    final selectedEvent = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 1),
          foregroundColor: Color(0xFFD1410C),
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 50,
          decoration: BoxDecoration(color: Colors.white),
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () => {},
            child: const Center(
              child: Text('Tickets'),
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    selectedEvent.imageUrl,
                    fit: BoxFit.cover,
                  )),
            ),
            Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Text(
                  selectedEvent.title,
                  style: TextStyle(
                      fontFamily: 'Nexa', fontSize: 30, height: 1.0005),
                ),
              ),
            ),
            Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Times are displayed in your local timezone',
                  style: TextStyle(
                      color: Color.fromARGB(255, 104, 104, 104), fontSize: 15),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: EventInfo(
                    DateFormat("d MMM yyyy")
                        .add_jm()
                        .format(selectedEvent.date),
                    selectedEvent.location,
                    selectedEvent.duration,
                    selectedEvent.price.toString(),
                    '5:00 pm',
                    selectedEvent.isOnline,
                    selectedEvent.isFree,
                    selectedEvent.summary)),
            SizedBox(height: 80)
          ],
        ));
  }
}
