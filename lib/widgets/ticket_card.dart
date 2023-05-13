///This widget is used to display the ticket card on the checkout screen.

import 'package:envie_cross_platform/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';
import 'counter.dart';

class TicketContainer extends StatefulWidget {
  Ticket ticket;
  int ticketIndex;

    TicketContainer({Key? key, required this.ticket, required this.ticketIndex})
      : super(key: key);

  @override
  _TicketContainerState createState() => _TicketContainerState();
}

class _TicketContainerState extends State<TicketContainer> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    List<Ticket> tickets = Provider.of<TicketsProvider>(context,listen: false).allTickets;
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
               widget.ticket.name,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'price: ${widget.ticket.price.toString()}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(widget.ticket.decription),
            ],
          ),
          trailing:
               HorizontalCounter(
              initialValue: 0,
              minValue: 0,
              maxValue: 10,
              index: widget.ticketIndex),
          horizontalTitleGap: BorderSide.strokeAlignCenter,
        ));
  }
}



