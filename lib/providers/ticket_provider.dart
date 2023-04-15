import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/ticket.dart';
import '../dummy_tickets.dart';

class TicketsProvider with ChangeNotifier {
  final List<Ticket> _tickets = dummyTickets;

  List<Ticket> get allTickets {
    return [..._tickets];
  }
}



// const url ="endpoint+verb"

//post request
///http.post(url,body: json.encode{
///  */map*/
///   'key': value
///}).then((response){
///  print(json.decode(response.body))
///  // code to be executed on response // then function in future  
///})
