import 'package:envie_cross_platform/widgets/event_list.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../dummy_data.dart';
import 'filter_events_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String dropdownValue = 'In my current Location';
  Map<String, bool> _filters = {
    'Music': false,
    'FoodAndDrink': false,
    'CharityAndCauses': false,
  };
  final List<Event> _AllEvents = DUMMY_EVENTS;
  List<Event> _filteredEvents = DUMMY_EVENTS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _filteredEvents = _AllEvents.where((event) {
        if (_filters['Music']! && !event.categories.contains('c1'))
          return false;
        if (_filters['FoodAndDrink']! && !event.categories.contains('c2'))
          return false;
        if (_filters['CharityAndCauses']! && !event.categories.contains('c3'))
          return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                labelText: 'Search for...',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 20),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 0,
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  items: <String>['In my current Location', 'Online']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FilterEventsScreen(_filters, _setFilters)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.tune, size: 20),
                        Text('Filters', style: TextStyle(fontSize: 12)),
                        Icon(Icons.arrow_drop_down_outlined),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Color.fromARGB(255, 192, 200, 231),
                      foregroundColor: Colors.black,
                      fixedSize: Size(125, 40),
                      alignment: Alignment.center,
                    )),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 15),
                        Text('Anytime', style: TextStyle(fontSize: 12)),
                        Icon(Icons.arrow_drop_down_outlined),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Color.fromARGB(255, 192, 200, 231),
                      foregroundColor: Colors.black,
                      fixedSize: Size(125, 40),
                      alignment: Alignment.center,
                    )),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.0),
            child: Text(_AllEvents.length.toString() + ' events',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.only(bottom: 50),
            child: EventsList(), // it was before EventList(_filteredEvents), but now since event list is a listener the list will be fetched by the provider
          ),
        ],
      ),
    );
  }
}
