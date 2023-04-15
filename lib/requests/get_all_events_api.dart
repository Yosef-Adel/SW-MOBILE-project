import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/events_provider.dart';
import 'routes_api.dart';

Future<List<Event>> getAllEvents(BuildContext context) async {
  final url = Uri.parse('${RoutesAPI.getAllEvents}');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    print('Response: ${jsonResponse}');
    print('${jsonResponse['events']}');
    int responseStatus = response.statusCode;
    List<Event> eventsList = [];
    if (responseStatus == 200) {
      for (var eventDict in jsonResponse['events']) {
        eventsList.add(Event.fromJson(eventDict));
      }
      return eventsList;
      //Provider.of<EventsProvider>(context, listen: false).AllEvents = eventsList;
    }
    return [];
  } catch (error) {
    print('Error: $error');
    return [];
  }
}
