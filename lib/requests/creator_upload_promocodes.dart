import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<File?> pickCsvFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if (result != null && result.files.isNotEmpty) {
    return File(result.files.single.path!);
  } else {
    return null;
  }
}

Future<void> creatorUploadPromocodes(
  BuildContext context,
  int percentOff,
  int amountOff,
  int limit,
  List<String> tickets,
  DateTime startDate,
  DateTime endDate,
) async {
  String? eventID = Provider.of<CreatorEventProvider>(context, listen: false)
      .selectedEventId!;
  String? token = Provider.of<UserProvider>(context, listen: false).token;

  final String baseUrl = '${RoutesAPI.checkPromo}$eventID/upload';
  Uri url = Uri.parse(baseUrl);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

//   if (result != null) {
//     PlatformFile file = result.files.first;
//     String fileName = file.name;
//     String filePath = file.path;

//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('https://your-upload-url.com'), // Replace with your upload endpoint
//     );
//     request.files.add(
//       await http.MultipartFile.fromPath(
//         'csv',
//         filePath,
//         filename: fileName,
//       ),
//     );

  final request = http.MultipartRequest('POST', url);

  File? csv = await pickCsvFile();

  if (csv != null) {
    print("CSV obtained");
    List<int> csvBytes = await csv.readAsBytes();
    http.MultipartFile csvFile = http.MultipartFile.fromBytes(
        'csvFile', csvBytes,
        filename: 'myfile.csv');

    //request.files.add(csvFile);
    request.fields['file'] = csvFile.toString();
    if (percentOff != -1) {
      request.fields['percentOff'] = percentOff.toString();
    }

    if (amountOff != -1) {
      request.fields['amountOff'] = amountOff.toString();
    }

    request.fields['tickets'] = tickets.join(',');
    request.fields['limit'] = limit.toString();

    //print(headers);
    //print('Token: ${token}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      //print('Response: ${response.body}');
      int responseStatus = response.statusCode;

      if (responseStatus == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CSV file uploaded successfully!')),
        );
        return;
      }
    } catch (error) {
      print('Error while uploading CSV file: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error while uploading CSV file')),
      );
      return;
    }
  } else {
    print("CSV file picking canceled");
    return;
  }
}
