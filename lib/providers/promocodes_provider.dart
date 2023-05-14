/// This file contains the provider for the promocodes screen.

import 'package:flutter/material.dart';

import '../models/ticket.dart';

class PromocodesProvider with ChangeNotifier {
  List<Ticket> _ticketsRetrieved = [];
  String? _selectedTicket;

  set ticketsRetrieved(List<Ticket> tickets) {
    _ticketsRetrieved = tickets;
    notifyListeners();
  }

  List<Ticket> get ticketsRetrieved {
    return [..._ticketsRetrieved];
  }

  set selectedTicket(String? ticket) {
    _selectedTicket = ticket;
    notifyListeners();
  }

  String? get selectedTicket {
    return _selectedTicket;
  }
}
