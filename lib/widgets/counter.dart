import 'dart:async';
import 'package:envie_cross_platform/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ticket.dart';

class HorizontalCounter extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int index;

   const HorizontalCounter(
      {Key? key,
      this.initialValue = 0,
      this.minValue = 0,
      this.maxValue = 10,
      required this.index})
      : super(key: key);

  @override
  _HorizontalCounterState createState() => _HorizontalCounterState();
}

class _HorizontalCounterState extends State<HorizontalCounter> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue;
  }

 void _incrementCount(BuildContext ctx) {
    var ticketProvider = Provider.of<TicketsProvider>(ctx, listen: false);
    List<Ticket> tickets = ticketProvider.allTickets;
    setState(() {
      if (_count < widget.maxValue) {
        _count++;
        tickets[widget.index].upgradeCount(_count);
      }
    });
    print(tickets[widget.index].count);
    print(tickets[widget.index].id);
  }

 void _decrementCount(BuildContext ctx) {
    var ticketProvider = Provider.of<TicketsProvider>(ctx, listen: false);
    List<Ticket> tickets = ticketProvider.allTickets;
    setState(() {
      if (_count > widget.minValue) {
        _count--;
        tickets[widget.index].upgradeCount(_count);
      }
    });
    print(tickets[widget.index].count);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon:(_count > widget.minValue)
              ? Icon(Icons.remove, color: Color(0xFFD1410C))
              : Icon(Icons.remove),
          onPressed:  () => _decrementCount(context),
        ),
        Text(
          '$_count',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: (_count < widget.maxValue)
              ? Icon(Icons.add, color: Color(0xFFD1410C))
              : Icon(Icons.add),
          onPressed:() => _incrementCount(context),
        ),
      ],
    );
  }
}
