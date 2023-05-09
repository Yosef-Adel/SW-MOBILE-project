import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<void> creatorPublishEvent(BuildContext context, bool isPrivate,
    bool isScheduled, String? password, DateTime publishDate) async {
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  eventID = '64331c1e1d3382d35d5b3a43';
  final String baseUrl = '${RoutesAPI.creatorGetEvents}/$eventID';
  Uri url = Uri.parse(baseUrl);

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  final Map<String, dynamic> body = {
    'isPrivate': isPrivate,
    'isScheduled': isScheduled,
  };
  if (password != null) {
    body['password'] = password;
  }
  if (isScheduled) {
    body['publishDate'] = publishDate;
  }

  //print(headers);
  //print('Token: ${token}');
  print(url);
  try {
    final response = await http.put(
      url,
      headers: headers,
      body: json.encode(body),
    );
    final jsonResponse = json.decode(response.body);
    //print('Response: ${jsonResponse}');

    int responseStatus = response.statusCode;

    if (responseStatus == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Saved Successfully'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    return;
  } catch (error) {
    print('Error in publish event: $error');
    return;
  }
}
