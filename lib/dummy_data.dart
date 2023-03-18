//import 'package:flutter/material.dart';

import './models/category.dart';
import './models/event.dart';

const DUMMY_CATEGORIES = [
  Category(
    id: 'c1',
    title: 'Music',
  ),
  Category(
    id: 'c2',
    title: 'Food & Drink',
  ),
  Category(
    id: 'c3',
    title: 'Charity & Causes',
  ),
];

final DUMMY_EVENTS = [
  Event(
    id: 'e1',
    title: 'Songwriting Workshop',
    categories: ['c1'],
    description: 'Learn how to write a song in this 2 hour workshop',
    imageUrl: 'assets/images/DemoEvent.jpg',
    isOnline: true,
    date: DateTime.parse('2023-05-27 17:00'),
    isFree: true,
    duration: 2.0,
  ),
  Event(
    id: 'e2',
    title: 'David Griffith fun music party',
    categories: ['c1', 'c2'],
    description:
        'david griffith throws a fun music party. Now, I deeply fall in love with music, the natural and unrestrained music',
    imageUrl: 'assets/images/DemoEvent.jpg',
    isOnline: false,
    location: 'The Music Room, 123 Main Street, New York, NY 10001',
    date: DateTime.parse('2023-11-05 12:00'),
    isFree: false,
    price: 10.0,
    duration: 3.0,
  ),
];
