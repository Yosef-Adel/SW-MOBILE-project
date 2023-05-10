import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<int> creatorPublishEvent(
    BuildContext context,
    bool isPrivate,
    bool isScheduled,
    bool isPublished,
    String? password,
    DateTime? publishDate) async {
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  final String baseUrl = '${RoutesAPI.creatorGetEvents}/$eventID';
  Uri url = Uri.parse(baseUrl);

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  if (isPrivate) {
    isScheduled = false;
    isPublished = false;
  }

  final Map<String, dynamic> body = {
    'isPrivate': isPrivate,
    'isScheduled': isScheduled,
    'isPublished': isPublished,
  };

  if (isPrivate && password != null) {
    body['password'] = password;
  }
  if (isScheduled && publishDate != null) {
    body['publishDate'] =
        DateFormat('yyyy-MM-dd\'T\'HH:mm').format(publishDate);
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
      return 0;
    } else
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error while publishing event'),
          backgroundColor: Colors.red,
        ),
      );

    return -1;
  } catch (error) {
    print('Error while publishing event: $error');
    return -1;
  }
}
