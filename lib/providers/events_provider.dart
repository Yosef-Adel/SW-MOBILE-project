import 'package:flutter/material.dart';
import '../models/event.dart';
import '../dummy_data.dart';

// ChangeNotifier enables inherited widgets to establish commmunication channels behind the scenes
class EventsProvider with ChangeNotifier {
  List<Event> _allEvents = [];
  // List<Event> _filteredEvents = [];
  // Map<String, bool> _filters = {
  //   'All': true,
  //   'Music': false,
  //   'FoodAndDrink': false,
  //   'CharityAndCauses': false,
  // };

  set allEvents(List<Event> events) {
    _allEvents = events;
    //refreshFilteredEvents();
    notifyListeners();
  }

  List<Event> get allEvents {
    return [..._allEvents];
  }

  // List<Event> get filteredEvents {
  //   //refreshFilteredEvents();
  //   return [..._filteredEvents];
  // }

  // Map<String, bool> get filters {
  //   return {..._filters};
  // }

//   void setAllFilter(bool value) {
//     _filters['All'] = value;
//     refreshFilteredEvents();
//     notifyListeners();
//   }

//   void setMusicFilter(bool value) {
//     _filters['Music'] = value;
//     refreshFilteredEvents();
//     notifyListeners();
//   }

//   void setFoodAndDrinkFilter(bool value) {
//     _filters['FoodAndDrink'] = value;
//     refreshFilteredEvents();
//     notifyListeners();
//   }

//   void setCharityAndCausesFilter(bool value) {
//     _filters['CharityAndCauses'] = value;
//     refreshFilteredEvents();
//     notifyListeners();
//   }

//   void refreshFilteredEvents() {
//     _filteredEvents = _allEvents.where((event) {
//       if (_filters['All']!) return true;
//       if (_filters['Music']! && event.categories.contains('c1')) return true;
//       if (_filters['FoodAndDrink']! && event.categories.contains('c2'))
//         return true;
//       if (_filters['CharityAndCauses']! && event.categories.contains('c3'))
//         return true;
//       return false;
//     }).toList();
//     //notifyListeners();
//   }

//   void addEvent() {
//     // _events.add(value);
//     notifyListeners();
//   }
}
