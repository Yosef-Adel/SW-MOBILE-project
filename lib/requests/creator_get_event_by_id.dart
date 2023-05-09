import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

//Static EventID for testing
Future<Event?> creatorGetEventById(BuildContext context, String eventId) async {
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final String baseUrl;
  eventId = '64583601b4a91dad5dec6418';
  baseUrl = '${RoutesAPI.creatorGetEvents}/$eventId';
  Uri url = Uri.parse(baseUrl);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  //print(headers);
  print('Token: ${token}');
  print(url);
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    //print('Response: ${jsonResponse}');

    int responseStatus = response.statusCode;

    if (responseStatus == 200) {
      Event event = Event.fromJson(jsonResponse);
      return event;
    }
    return null;
  } catch (error) {
    print('Error in getting event ID: $error');
    return null;
  }
}
