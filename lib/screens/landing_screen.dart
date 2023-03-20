import 'package:envie_cross_platform/widgets/event_list.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';

class LandingScreen extends StatefulWidget {
  final _AllEvents = [
    Event(
      id: 'e1',
      title: 'Songwriting Workshop',
      categories: ['c1'],
      description: 'Learn how to write a song in this 2 hour workshop',
      imageUrl: "assets/images/DemoEvent.jpg",
      isOnline: true,
      date: DateTime.parse('2023-05-27 17:00'),
      isFree: true,
      duration: 2.0,
    ),
    Event(
      id: 'e2',
      title: 'David Griffith music party',
      categories: ['c1', 'c2'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/DemoEvent.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: 3.0,
    ),
    Event(
      id: 'e3',
      title: 'Songwriting Workshop',
      categories: ['c1'],
      description: 'Learn how to write a song in this 2 hour workshop',
      imageUrl: "assets/images/DemoEvent.jpg",
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York',
      date: DateTime.parse('2023-05-27 17:00'),
      isFree: true,
      duration: 2.0,
    ),
    Event(
      id: 'e4',
      title: 'David Griffith music party',
      categories: ['c1', 'c2'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/DemoEvent.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York, NY',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: 3.0,
    ),
    Event(
      id: 'e4',
      title: 'David Griffith music party',
      categories: ['c1', 'c2'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/DemoEvent.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York, NY',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: 3.0,
    ),
    Event(
      id: 'e4',
      title: 'David Griffith music party',
      categories: ['c1', 'c2'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/DemoEvent.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York, NY',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: 3.0,
    ),
    Event(
      id: 'e4',
      title: 'David Griffith music party',
      categories: ['c1', 'c2'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/DemoEvent.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York, NY',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: 3.0,
    ),
    Event(
      id: 'e4',
      title: 'David Griffith music party',
      categories: ['c1', 'c2'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/DemoEvent.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York, NY',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: 3.0,
    ),
    Event(
      id: 'e4',
      title: 'David Griffith music party',
      categories: ['c1', 'c2'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/DemoEvent.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York, NY',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: 3.0,
    ),
    Event(
      id: 'e4',
      title: 'David Griffith music party',
      categories: ['c1', 'c2'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/DemoEvent.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York, NY',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: 3.0,
    ),
  ];

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String dropdownValue = 'In my current Location';

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
                  items: <String>['In my current Location', 'Online']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 10),
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
          SizedBox(height: 5),
          Container(height: 500, child: EventsList(widget._AllEvents)),
        ],
      ),
    );
  }
}
