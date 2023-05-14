/// This file contains the API for placing an order for a creator.

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/ticket.dart';
import 'routes_api.dart';

Future<bool> creatorPlaceOrder(
      {required String firstname,
      required String lastname,
      required String email,
      required List<Ticket> tickets,
      required String eventId,
      String? token,
      required String userId}) async {
    final url = Uri.parse(
        '${RoutesAPI.creatorGetEvents}/${eventId}/${userId}/attendees');
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
        ticket["faceValue"] = tickets[i].price;
        ticket['number'] = tickets[i].count;
        ticketsBought.add(ticket);
      }
    }
    var body;
    body = json.encode({
      'ticketsBought': ticketsBought,
      'firstName': firstname,
      'lastName': lastname,
      'email': email
    });
    //print(body);

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      final jsonResponse = json.decode(response.body);
      //print(response.body);
      //print(response.statusCode);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error while placing order: $error');
      throw 'Failed to place order';
    }
  }