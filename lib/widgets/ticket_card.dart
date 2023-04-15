import 'package:flutter/material.dart';
import 'counter.dart';

class TicketContainer extends StatefulWidget {
  final String title;
  final String description;

  TicketContainer({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  _TicketContainerState createState() => _TicketContainerState();
}

class _TicketContainerState extends State<TicketContainer> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
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
              widget.title,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(
            widget.description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          trailing:
              HorizontalCounter(initialValue: 0, minValue: 0, maxValue: 10),
          horizontalTitleGap: BorderSide.strokeAlignCenter,
        ));
  }
}



