
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/ticket.dart';
import '../providers/ticket_provider.dart';
import 'routes_api.dart';

Future<List<Ticket>> getAllTicketsForAnEvent(
    BuildContext ctx, String eventId) async {
  final url = Uri.parse(
      '${RoutesAPI.getAllTickets}/ticket/${eventId}/availableTickets');

  final headers = {'Content-Type': 'application/json'};
  var ticketProvider = Provider.of<TicketsProvider>(ctx,listen: false);
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    print('Response: ${jsonResponse}');
    print('${jsonResponse['events']}');
    int responseStatus = response.statusCode;
    List<Ticket> ticketsList = [];
    if (responseStatus == 200) {
      for (var ticketDict in jsonResponse['tickets']) {
        ticketsList.add(Ticket.fromJson(ticketDict));
      }
      print(ticketsList);
      print('Ana hakhosh aho el provider');
      ticketProvider.setTickets = ticketsList;
      print('Ana kharagt aho men el provider');
      print(ticketProvider.allTickets);
      return ticketsList;
    }
    return [];
  } catch (error) {
    print(error);
    return [];
  }
}