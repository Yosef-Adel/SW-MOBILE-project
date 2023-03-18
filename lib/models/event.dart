import 'package:flutter/material.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final String summary;
  final String imageUrl;
  final bool isOnline;
  final String location;
  final DateTime date;
  final List<String> categories;
  final bool isFree;
  final double price;
  final double duration;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    this.summary = "",
    required this.imageUrl,
    required this.isOnline,
    this.location = "",
    required this.date,
    required this.categories,
    required this.isFree,
    this.price = 0.0,
    required this.duration,
  });
}
