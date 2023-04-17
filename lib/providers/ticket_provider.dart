import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/ticket.dart';
import '../dummy_tickets.dart';

class TicketsProvider with ChangeNotifier {
 List<Ticket> _tickets = [];

  // TicketsProvider(List<Ticket> tickets) {
  //   this._tickets = tickets;
  //   notifyListeners();
  // }

  set setTickets(List<Ticket> tickets) {
    _tickets = tickets;
    notifyListeners();
  }

  void upgradeCount(int index, int counter) {
    _tickets[index].count = counter;
    notifyListeners();
  }

  void discountPrice(int index, int discount) {
    _tickets[index].price =(_tickets[index].price*(discount / 100)).ceil();
    notifyListeners();
  }

  List<Ticket> get allTickets {
    return [..._tickets];
  }
}
