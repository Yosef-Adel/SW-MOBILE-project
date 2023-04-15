import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';
import 'ticket_card.dart';

class TicketInfo extends StatefulWidget {
  @override
  State<TicketInfo> createState() => _TicketInfoState();
}

class _TicketInfoState extends State<TicketInfo> {
  @override
  Widget build(BuildContext context) {
    final ticketsData = Provider.of<TicketsProvider>(context).allTickets;
    // print(ticketsData);
    return ListView.builder(
      itemCount: ticketsData.length,
      itemBuilder: (BuildContext context, int index) {
        return
            // ListTile(
            //   title: Text(ticketsData[index].title),
            //   subtitle: Text(ticketsData[index].price.toString()),
            // ),
            TicketContainer(
                title: ticketsData[index].title,
                description: ticketsData[index].price.toString());
      },
    );
  }
}