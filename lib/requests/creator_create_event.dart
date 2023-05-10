
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

  // print(event.summary);
  // print(event.venueName);
  // print(event.city);
  // print(event.address1);
  // print(event.country);
  // print(event.postalCode);
  // print(event.category);
  
  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Content-Type'] = 'application/json';
  request.fields['name'] = event.title;
  request.fields['startDate'] =
      DateFormat('yyyy-MM-dd\'T\'HH:mm').format(event.startDate);
  request.fields['endDate'] =
      DateFormat('yyyy-MM-dd\'T\'HH:mm').format(event.endDate);
  request.fields['category'] = event.category;
  request.fields['summary'] = event.summary!;
  request.fields['venueName'] = event.venueName!;
  request.fields['city'] = event.city!;
  request.fields['address1'] = event.venueName.toString() +
      ', ' +
      event.city.toString() +
      ', ' +
      event.country.toString();
  request.fields['country'] = event.country!;
  request.fields['postalCode'] = "11571";
  request.fields['capacity'] = event.capacity.toString();
  // request.fields['createdBy'] = usrId;
  request.fields['isOnline'] = event.isOnline.toString();

  print(url);
  //print(token);

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  try {
    //Intercept the request and log its contents
    // final requestStreamed = await request.finalize();
    // final contents = await requestStreamed.bytesToString();
    // print('Request Body: $contents');
    final response = await http.Response.fromStream(await request.send());
    final jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    final message = jsonResponse["message"];
    //print(message);

    if (message == "Event created successfully") {
      //print("json response :"+ jsonResponse['event']['_id']);
      return [jsonResponse['event']['_id'], jsonResponse["message"]];
    } else {
      return ["", jsonResponse["message"]];
    }
  } catch (error) {
    print('Error while creating event: $error');
    throw 'failed to create event';
  }
}


/*
 {event: {name: law ta3ban ta3ala, description: lel nas elle msh asdra teegy, startDate: 2023-05-07T00:00:00.000Z, endDate: 2023-05-07T00:00:00.000Z, price: -1, summary: summary, capacity: 1000, category: Music, tickets: [], createdBy: 642ccf6ef33cc2615a9aa55f, isPrivate: false, venueName: ka3et elle msh 2adreen, city: giza, address1: ka3et elle msh 2adreen, country: Egypt, postalCode: 11571, isOnline: false, _id: 6457e2bc874c7e0ba01e39db, createdAt: 2023-05-07T17:41:16.532Z, updatedAt: 2023-05-07T17:41:16.532Z, __v: 0}, message: Event created successfully}
*/