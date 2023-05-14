/// This file contains the request for uploading promocodes from a CSV file.

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';

import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<File?> pickCsvFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if (result != null && result.files.isNotEmpty)
    return File(result.files.single.path!);

  return null;
}

Future<int> creatorUploadPromocodes(
  BuildContext context,
  File? csv,
  int percentOff,
  int amountOff,
  int limit,
  String tickets,
  DateTime startDate,
  DateTime endDate,
) async {
  String? eventID = Provider.of<CreatorEventProvider>(context, listen: false)
      .selectedEventId!;
  String? token = Provider.of<UserProvider>(context, listen: false).token;

  final String baseUrl = '${RoutesAPI.checkPromo}$eventID/upload';
  Uri url = Uri.parse(baseUrl);

  final request = http.MultipartRequest('POST', url);

  request.headers.addAll(
      {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'});

  if (csv != null) {
    var stream = http.ByteStream(csv.openRead());
    var length = await csv.length();

    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: csv.path.split('/').last, //path.basename(csv.path),
      contentType: MediaType('text', 'csv'),
    );

    request.files.add(multipartFile);

    if (percentOff != -1) {
      request.fields['percentOff'] = percentOff.toString();
    }

    if (amountOff != -1) {
      request.fields['amountOff'] = amountOff.toString();
    }

    request.fields['tickets'] = tickets;
    request.fields['limit'] = limit.toString();

    request.fields['startDate'] = startDate.toIso8601String();
    request.fields['endDate'] = endDate.toIso8601String();

    //print(headers);
    //print('Token: ${token}');
    print(url);
    try {
      final response = await request.send();

      final responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      int responseStatus = response.statusCode;
      //print(responseStatus);
      //print(responseData);

      if (responseStatus == 200) {
        return 0;
      }
    } catch (error) {
      print('Error while uploading CSV file: $error');
      return -1;
    }
    return -1;
  } else {
    print("CSV file picking canceled");
    return -1;
  }
}
