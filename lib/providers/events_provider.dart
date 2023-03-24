import 'package:flutter/material.dart';
import '../models/event.dart';

// change notifiers enables inherited widgets to establish commmunication channels behind the scenes
class Events with ChangeNotifier {
  List<Event> _events = [
     Event(
      id: 'e1',
      title: 'Songwriting Workshop',
      categories: ['c1'],
      description: 'Learn how to write a song in this 2 hour workshop',
      imageUrl: "assets/images/DemoEvent.jpg",
      isOnline: true,
      date: DateTime.parse('2023-05-27 17:00'),
      isFree: true,
      duration: '2 hours',
      summary:
          'Calling All Climate Warriors! Youth for Climate Justice is hosting a series of webinars where we feature three climate justice-focused initiatives spearheaded by young community organizers. Discover local movements in your community, learn about effective ways to communicate with legislators and lead the charge in climate justice! Series dates: April 20, May 16, June 21'
    ),
  Event(
      id: 'e2',
      title: 'David Griffith music party',
      categories: ['c1', 'c2'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/Pyramids.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: '9 hours',
      summary:
          'Calling All Climate Warriors! Youth for Climate Justice is hosting a series of webinars where we feature three climate justice-focused initiatives spearheaded by young community organizers. Discover local movements in your community, learn about effective ways to communicate with legislators and lead the charge in climate justice! Series dates: April 20, May 16, June 21'),
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
      duration: '2 days',
      summary:
          'Calling All Climate Warriors! Youth for Climate Justice is hosting a series of webinars where we feature three climate justice-focused initiatives spearheaded by young community organizers. Discover local movements in your community, learn about effective ways to communicate with legislators and lead the charge in climate justice! Series dates: April 20, May 16, June 21'),
  Event(
      id: 'e4',
      title: 'Halloween Party',
      categories: ['c3'],
      description:
          'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
      imageUrl: 'assets/images/DemoEvent.jpg',
      isOnline: false,
      location: 'The Music Room, 123 Main Street, New York, NY',
      date: DateTime.parse('2023-11-05 12:00'),
      isFree: false,
      price: 10.0,
      duration: '3 hours',
      summary:
          'Guest speakers: Adrien Young, project manager of the Green Bottle Movement; Kim Chul-San, president of legal consultancy For Tomorrow; and Elena Ignacio, spokesperson for the One Planet advocacy organization.'),
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
      duration: '30 minutes',
      summary:
          'Guest speakers: Adrien Young, project manager of the Green Bottle Movement; Kim Chul-San, president of legal consultancy For Tomorrow; and Elena Ignacio, spokesperson for the One Planet advocacy organization.'),
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
      duration: '5 hours',
      summary:
          'Guest speakers: Adrien Young, project manager of the Green Bottle Movement; Kim Chul-San, president of legal consultancy For Tomorrow; and Elena Ignacio, spokesperson for the One Planet advocacy organization.'),
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
      duration: '24 hours',
      summary:
          'Guest speakers: Adrien Young, project manager of the Green Bottle Movement; Kim Chul-San, president of legal consultancy For Tomorrow; and Elena Ignacio, spokesperson for the One Planet advocacy organization.'),
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
      duration: '15 minutes',
      summary:
          'Guest speakers: Adrien Young, project manager of the Green Bottle Movement; Kim Chul-San, president of legal consultancy For Tomorrow; and Elena Ignacio, spokesperson for the One Planet advocacy organization.'),
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
      duration: '25 minutes',
      summary:
          'Guest speakers: Adrien Young, project manager of the Green Bottle Movement; Kim Chul-San, president of legal consultancy For Tomorrow; and Elena Ignacio, spokesperson for the One Planet advocacy organization.'),
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
      duration: '16 minutes',
      summary:
          'Guest speakers: Adrien Young, project manager of the Green Bottle Movement; Kim Chul-San, president of legal consultancy For Tomorrow; and Elena Ignacio, spokesperson for the One Planet advocacy organization.'),

  ];

  List<Event> get events {
    return [..._events];
  }

  void addEvent() {
    // _events.add(value);
    notifyListeners();
  }
}
