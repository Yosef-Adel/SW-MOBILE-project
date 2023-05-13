import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/ticket.dart';
import '../providers/creator_event_provider.dart';
import '../providers/promocodes_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<List<Ticket>> creatorGetAllTickets(BuildContext context) async {
  String? eventId = Provider.of<CreatorEventProvider>(context, listen: false)
      .selectedEventId!;
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

    int responseStatus = response.statusCode;
    //print('Response Status: $responseStatus');
    //print('Response: ${response.body}');
    List<Ticket> ticketsList = [];
    if (responseStatus == 200) {
      for (var ticketDict in jsonResponse['tickets']) {
        ticketsList.add(Ticket.fromJsonCreator(ticketDict));
      }
      if (ticketsList.isNotEmpty) {
        Provider.of<PromocodesProvider>(context, listen: false).ticketsRetrieved =
            ticketsList;
        Provider.of<PromocodesProvider>(context, listen: false).selectedTicket =
            ticketsList[0].id;
        return ticketsList;
      }  
    }
    return [];
  } catch (error) {
    print("Error in getting tickets: $error");
    return [];
  }
}
