/// This file contains the function to export all events created by the user as a CSV file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<void> creatorExportEvents(BuildContext context) async {
  String? userID = Provider.of<UserProvider>(context, listen: false).user.id;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  //print(token);
  final String baseUrl =
      '${RoutesAPI.creatorGetEvents}/$userID/all-events/download';
  Uri url = Uri.parse(baseUrl);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  //print(headers);
  //print('Token: ${token}');
  print(url);
  try {
    final response = await http.get(
      url,
      headers: headers,
    );

    //print('Response: ${response.body}');
    int responseStatus = response.statusCode;

    if (responseStatus != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $responseStatus')),
      );
      return;
    }
    // Request permission to access the device's storage.
    // final status = await Permission.storage.request();

    // Get the directory path for storing files
    final directory = await getExternalStorageDirectory();

    if (directory != null) {
      //print(directory.path);
      String filePath = directory.path + '/MyEvents.csv';

      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('CSV file exported successfully'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );

      return;
      //}
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Failure'),
          content: Text('Permission denied! Could not export CSV file'),
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
    print('Error while exporting: $error');
    return;
  }
}
