import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ticket.dart';
import '../providers/ticket_provider.dart';
import 'ticket_card.dart';
import '../requests/get_all_tickets_api.dart';
import 'loading_indicator.dart';

class TicketInfo extends StatefulWidget {
  final String eventId;
  TicketInfo(this.eventId);
  @override
  State<TicketInfo> createState() => _TicketInfoState();
}

class _TicketInfoState extends State<TicketInfo> {
   late Future<List<Ticket>> _ticketsFuture;
  @override
  void initState() {
    super.initState();
    _ticketsFuture = getAllTicketsForAnEvent(context, widget.eventId);
  }


  @override
  Widget build(BuildContext context) {
    final ticketsData = Provider.of<TicketsProvider>(context).allTickets;
    // print(ticketsData);
    return FutureBuilder(
        future: _ticketsFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('loading');
            return LoadingIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return
                    // ListTile(
                    //   title: Text(ticketsData[index].title),
                    //   subtitle: Text(ticketsData[index].price.toString()),
                    // ),
                    TicketContainer(ticket: snapshot.data[index], ticketIndex: index);
              },
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        });
  }
}