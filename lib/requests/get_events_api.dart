import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/categories_provider.dart';
import 'routes_api.dart';

Future<LocationData?> getLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }
  LocationData _locationData;
  _locationData = await location.getLocation();
  //print(_locationData.latitude);
  //print(_locationData.longitude);
  return _locationData;
}

Future<List<Event>> getEvents(BuildContext context) async {
  String? categoryID =
      Provider.of<CategoriesProvider>(context).selectedCategoryID;
  LocationData? geoLocation = await getLocation();

  final url = (categoryID != null)
      ? Uri.parse(
          '${RoutesAPI.getEvents}?category=${categoryID}&lat=${geoLocation?.latitude}&lng=${geoLocation?.longitude}')
      : Uri.parse(
          '${RoutesAPI.getEvents}?lat=${geoLocation?.latitude}&lng=${geoLocation?.longitude}');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    //print('Response: ${jsonResponse}');
    //print(url);
    //print('${jsonResponse['events']}');
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
