/// This file contains the provider for the tickets. It contains the list of tickets and the methods to update the tickets.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/ticket.dart';

class TicketsProvider with ChangeNotifier {
  List<Ticket> _tickets = [];

  set setTickets(List<Ticket> tickets) {
    _tickets = tickets;
    notifyListeners();
  }

  void upgradeCount(int index, int counter) {
    _tickets[index].count = counter;
    notifyListeners();
  }

  void discountPrice(int index, int discount) {
    _tickets[index].price = (_tickets[index].price * (discount / 100)).ceil();
    notifyListeners();
  }

  List<Ticket> get allTickets {
    return [..._tickets];
  }
}
