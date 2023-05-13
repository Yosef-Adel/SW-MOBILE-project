/// This file contains the card widget for the creator's event list. 

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../providers/creator_event_provider.dart';
import '../requests/creator_get_event_by_id.dart';
import '../screens/creator_show_basic_info.dart';

class CreatorEventCard extends StatelessWidget {
  final String eventId;
  final String title;
  final String date;
  final String soldTickets;
  final String totalTickets;

  CreatorEventCard(
      {required this.eventId,
      required this.title,
      required this.date,
      required this.soldTickets,
      required this.totalTickets});

  void creatorSelectEvent(BuildContext ctx, String eventId) async {
    Provider.of<CreatorEventProvider>(ctx, listen: false).selectedEventId =
        eventId;
    Event? newEvent = await creatorGetEventById(ctx, eventId);
    if (newEvent != null) {
      Provider.of<CreatorEventProvider>(ctx, listen: false).selectedEvent =
          newEvent;
      //print(newEvent.totalTickets);
      Navigator.of(ctx).pushReplacementNamed(CreatorShowBasicInfo.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => creatorSelectEvent(context, eventId),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  date,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                  ),
                ),
              ),
              SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "$soldTickets/$totalTickets",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
