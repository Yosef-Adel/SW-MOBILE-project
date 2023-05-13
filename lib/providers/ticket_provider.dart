/// This file contains the provider for the tickets. It contains the list of tickets and the methods to update the tickets.

import 'package:flutter/material.dart';

import '../models/ticket.dart';

class TicketsProvider with ChangeNotifier {
  List<Ticket> _tickets = [];
  int _count = 0;

  set count(int c) {
    _count = c;
    notifyListeners();
  }

  int get count {
    return _count;
  }

  set setTickets(List<Ticket> tickets) {
    _tickets = tickets;
    notifyListeners();
  }

  void discountPrice(int index, double discount) {
    _tickets[index].price = _tickets[index].price * (discount / 100);
    notifyListeners();
  }

  List<Ticket> get allTickets {
    return [..._tickets];
  }
}
