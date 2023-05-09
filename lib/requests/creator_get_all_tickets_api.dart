import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/ticket.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<List<Ticket>> creatorGetAllTickets(
    BuildContext context, String eventId) async {
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final url = Uri.parse('${RoutesAPI.getAllTickets}${eventId}/allTickets');

  print(url);
  //print('Token: $token');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    //print('Response: ${jsonResponse}');

    int responseStatus = response.statusCode;
    List<Ticket> ticketsList = [];
    if (responseStatus == 200) {
      for (var ticketDict in jsonResponse['tickets']) {
        ticketsList.add(Ticket.fromJsonCreator(ticketDict));
      }
      return ticketsList;
    }
    return [];
  } catch (error) {
    print("Error in getting tickets: $error");
    return [];
  }
}
