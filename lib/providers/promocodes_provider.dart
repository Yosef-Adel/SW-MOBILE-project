import 'package:flutter/material.dart';

import '../models/ticket.dart';
// import '../requests/creator_get_all_tickets_api.dart';

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

  // String? getSelectedTicketId(String item) {
  //   for (var ticket in ticketsRetrieved) {
  //     if (ticket.name == item) {
  //       return ticket.id;
  //     }
  //   }
  //   return null;
  // }

  // Future<List<String>> fetchTicketNames(BuildContext context) async {
  //   ticketsRetrieved = await creatorGetAllTickets(context);
  //   List<String> ticketNames = [];
  //   for (var ticket in ticketsRetrieved) {
  //     ticketNames.add(ticket.name);
  //   }
  //   print(ticketNames);
  //   return ticketNames;
  // }
}
