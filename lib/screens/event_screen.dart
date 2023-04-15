///This screen is displayed when the user clicks on an event from the events screen.
///The screen contains the event details and a button to buy tickets.

import 'package:intl/intl.dart';

import '../models/event.dart';
import 'package:flutter/material.dart';
import 'package:envie_cross_platform/widgets/event_info_widget.dart';
import 'tickets_screen.dart';

class EventScreen extends StatelessWidget {
  //final String id;
  //final String appBarText;
  static const routeName = '/event-details';

   void goToTicketScreen(
      BuildContext ctx, String title, String date, String id) {
    Navigator.of(ctx).pushNamed(TicketsScreen.routeName,
        arguments: {'eventTitle': title, 'eventDate': date, 'eventId': id});
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvent = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 1),
          foregroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 50,
          decoration: BoxDecoration(color: Colors.white),
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
             onPressed: () => goToTicketScreen(
                context,
                selectedEvent.title,
                DateFormat("d MMM yyyy").add_jm().format(selectedEvent.startDate),
                selectedEvent.id),
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
                  child: Image.network(
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
                    dateTime: DateFormat("d MMM yyyy")
                        .add_jm()
                        .format(selectedEvent.startDate),
                    location: selectedEvent.venueName,
                    //selectedEvent.duration,
                    price: selectedEvent.price.toString(),
                    startAt: '5:00 pm',
                    isOnline: selectedEvent.isOnline,
                    //selectedEvent.isFree,
                    summary: selectedEvent.summary)),
            SizedBox(height: 80)
          ],
        ));
  }
}
