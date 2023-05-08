import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/ticket.dart';
import 'routes_api.dart';

Future<List<Ticket>> getAllTickets(
    BuildContext ctx, String eventId, String token) async {
  final url =
      Uri.parse('${RoutesAPI.getAllTickets}/ticket/${eventId}/allTickets');
  print(url);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  final response = await http.get(
    url,
    headers: headers,
  );
  final jsonResponse = json.decode(response.body);
  print('Response: ${jsonResponse}');
  print('${jsonResponse['tickets']}');
  int responseStatus = response.statusCode;
  List<Ticket> ticketsList = [];
  if (responseStatus == 200) {
    for (var ticketDict in jsonResponse['tickets']) {
      ticketsList.add(Ticket.fromJson(ticketDict));
    }
    print(ticketsList);
    return ticketsList;
  } else {
    print('request failed');
    return [];
  }
}
