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
  String? categoryName = Provider.of<CategoriesProvider>(context, listen: false)
      .selectedCategoryName;
  String? selectedTimeCategory =
      Provider.of<CategoriesProvider>(context, listen: false)
          .selectedTimeCategory;
  LocationData? geoLocation = await getLocation();
  bool isOnCategory =
      Provider.of<CategoriesProvider>(context, listen: false).isOnlineCategory;

  final String baseUrl = '${RoutesAPI.getEvents}';
  String queryString = '';

  // Conditionally add each parameter to the query string
  if (categoryName != null) {
    if (queryString.isNotEmpty) {
      queryString += '&';
    } else {
      queryString += '?';
    }
    queryString += 'category=$categoryName';
  }

  if (isOnCategory == true) {
    if (queryString.isNotEmpty) {
      queryString += '&';
    } else {
      queryString += '?';
    }
    queryString += 'isOnline=$isOnCategory';
  } else if (geoLocation != null) {
    if (queryString.isNotEmpty) {
      queryString += '&';
    } else {
      queryString += '?';
    }
    queryString += 'lat=${geoLocation.latitude}&lng=${geoLocation.longitude}';
  }

  if (selectedTimeCategory != null) {
    if (queryString.isNotEmpty) {
      queryString += '&';
    } else {
      queryString += '?';
    }
    queryString += 'time=$selectedTimeCategory';
  }
  print(baseUrl + queryString);
  Uri url = Uri.parse(baseUrl + queryString);
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    //print('Response: ${jsonResponse}');
    int responseStatus = response.statusCode;
    List<Event> eventsList = [];
    if (responseStatus == 200) {
      for (var eventDict in jsonResponse['events']) {
        eventsList.add(Event.fromJson(eventDict));
      }
      return eventsList;
    }
    return [];
  } catch (error) {
    print('Error: $error');
    return [];
  }
}
