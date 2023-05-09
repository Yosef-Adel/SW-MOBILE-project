import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/event.dart';
import 'routes_api.dart';

Future<List<Object>> createEvent(BuildContext ctx, File? imageFile, Event event,
    String token, String usrId) async {
  final url = Uri.parse('${RoutesAPI.createEvent}');
  final request = http.MultipartRequest('POST', url);
  if (imageFile != null) {
    final fileStream = http.ByteStream(imageFile.openRead());
    final fileLength = await imageFile.length();
    final multiPartFile = http.MultipartFile('image', fileStream, fileLength,
        filename: imageFile.path.split('/').last);
    request.files.add(multiPartFile);
  }

  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Content-Type'] = 'application/json';
  request.fields['name'] = event.title;
  request.fields['startDate'] =
      DateFormat('yyyy-MM-dd\'T\'HH:mm').format(event.startDate);
  request.fields['endDate'] =
      DateFormat('yyyy-MM-dd\'T\'HH:mm').format(event.endDate);
  request.fields['description'] = event.description;
  request.fields['category'] = event.categoryId;
  request.fields['summary'] = event.summary;
  request.fields['venueName'] = event.venueName;
  request.fields['city'] = event.city;
  request.fields['address1'] = event.venueName;
  request.fields['country'] = event.country;
  request.fields['postalCode'] = '11571';
  request.fields['capacity'] = "1000";
  request.fields['createdBy'] = usrId;

  print(url);
  //print(token);

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  //print(event.title);

  // var body = json.encode({
  //   'name': event.title,
  //   'startDate': event.startDate.toString(),
  //   'endDate': event.endDate.toString(),
  //   'description': event.description,
  //   'category': "641fec455ce457366b03dabd",
  //   'hostedBy': "6431f393ed12506eeea7562b",
  //   'summary': event.summary,
  //   'venueName': event.venueName,
  //   'city': event.city,
  //   'address1': event.venueName,
  //   'country': event.country,
  //   'postalCode': '11571',
  //   'capacity': capacity,
  //   'image': base64Image,
  // });

  try {
    // Intercept the request and log its contents
    //  final requestStreamed = await request.finalize();
    //  final contents = await requestStreamed.bytesToString();
    //  print('Request Body: $contents');
    final response = await http.Response.fromStream(await request.send());
    final jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    final message = jsonResponse["message"];
    //print(message);

    if (message == "Event created successfully") {
      //print("json response :"+ jsonResponse['event']['_id']);
      return [jsonResponse['event']['_id'],jsonResponse["message"]];
    } else {
      return ["",jsonResponse["message"]];
    }
  } catch (error) {
    print('Error while creating event: $error');
    throw 'failed to create event';
  }
}


/*
 {event: {name: law ta3ban ta3ala, description: lel nas elle msh asdra teegy, startDate: 2023-05-07T00:00:00.000Z, endDate: 2023-05-07T00:00:00.000Z, price: -1, summary: summary, capacity: 1000, category: Music, tickets: [], createdBy: 642ccf6ef33cc2615a9aa55f, isPrivate: false, venueName: ka3et elle msh 2adreen, city: giza, address1: ka3et elle msh 2adreen, country: Egypt, postalCode: 11571, isOnline: false, _id: 6457e2bc874c7e0ba01e39db, createdAt: 2023-05-07T17:41:16.532Z, updatedAt: 2023-05-07T17:41:16.532Z, __v: 0}, message: Event created successfully}
*/