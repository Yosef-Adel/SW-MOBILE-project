/// This file contains the EventsProvider class which is used to manage the events data. It contains the list of events and the methods to update the events.

import 'package:flutter/material.dart';
import '../models/event.dart';

class CreatorEventsProvider with ChangeNotifier {
  List<Event> _allEvents = [];

  set allEvents(List<Event> events) {
    _allEvents = events;
    notifyListeners();
  }

  List<Event> get allEvents {
    return [..._allEvents];
  }

  void addEvent(Event e) {
    _allEvents.add(e);
    notifyListeners();
  }
}
