/// This file contains the API for placing an order for a user.

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/ticket.dart';
import 'routes_api.dart';

Future<bool> userPlaceOrder(
    {required String firstname,
    required String lastname,
    required String email,
    required List<Ticket> tickets,
    required String eventId,
    String? token,
    required String promoCodeId}) async {
  final url = Uri.parse('${RoutesAPI.placeOrder}${eventId}');
  print(url);
  //print(token);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  var ticketsBought = [];

  for (int i = 0; i < tickets.length; ++i) {
    Map<String, dynamic> ticket = {};
    if (tickets[i].count > 0) {
      //print(tickets[i].id);
      //print(tickets[i].count);
      ticket["ticketClass"] = tickets[i].id;
      ticket['number'] = tickets[i].count;
      ticketsBought.add(ticket);
    }
  }
  var body;
  if (promoCodeId == null || promoCodeId.isEmpty) {
    body = json.encode({
      'ticketsBought': ticketsBought,
      'firstName': firstname,
      'lastName': lastname,
      'email': email
    });
  } else {
    body = json.encode({
      'ticketsBought': ticketsBought,
      'promocode': promoCodeId,
      'firstName': firstname,
      'lastName': lastname,
      'email': email
    });
  }

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    //print(response.body);
    final jsonResponse = json.decode(response.body);
    final message = jsonResponse["message"];
    if (message == "Order created successfully!") {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Error while placing order: $error');
    throw 'Failed to place order';
  }
}
