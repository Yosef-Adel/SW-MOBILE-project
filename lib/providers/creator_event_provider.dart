import 'package:flutter/material.dart';
import '../models/event.dart';

class CreatorEventProvider with ChangeNotifier {
  Event? _selectedEvent;
  String? _selectedEventId;

  set selectedEvent(Event? e) {
    _selectedEvent = e;
    notifyListeners();
  }

  Event? get selectedEvent {
    return _selectedEvent;
  }

  set selectedEventId(String? id) {
    _selectedEventId = id;
    notifyListeners();
  }

  String? get selectedEventId {
    return _selectedEventId;
  }
}
