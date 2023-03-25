///This screen is the landing screen of our application. It contains the search bar, the filter button and the list of events.
///It is the first screen that the user sees when opening the app. It is a stateful widget because it contains a text field that the user can type in and we need to be able to access the text that the user types in.
///The build method returns a SingleChildScrollView widget. This is because we want the user to be able to scroll down the page if there are too many events to fit on the screen.
///The SingleChildScrollView widget takes a child widget as an argument. In this case, the child widget is a Column widget. The Column widget takes a list of widgets as an argument. In this case, the list contains a SizedBox widget, a TextField widget, a Row widget and an EventList widget. The SizedBox widget is used to add some space between the top of the screen and the TextField widget.
///The TextField widget is used to allow the user to search for events. The Row widget contains a Text widget and a FilterEventsScreen widget. The Text widget is used to display the text 'Filter by'. The FilterEventsScreen widget is used to allow the user to filter the events by category. The EventList widget is used to display the list of events.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/events_provider.dart';
import 'filter_events_screen.dart';
import '../widgets/events_list.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String dropdownValue = 'In my current Location';

  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<EventsProvider>(context);
    final events = eventsData.filteredEvents;
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
          Container(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0, right: 5.0),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: ElevatedButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(FilterEventsScreen.routeName),
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
                        // fixedSize:
                        //     Size(MediaQuery.of(context).size.width * 0.4, 40),
                        alignment: Alignment.center,
                      )),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: ElevatedButton(
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
                        //fixedSize: Size(125, 40),
                        alignment: Alignment.center,
                      )),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.0),
            child: Text(events.length.toString() + ' events',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.only(bottom: 50),
            child: EventsList(),
          ),
        ],
      ),
    );
  }
}
