import 'package:flutter/material.dart';

class CreatorEventCard extends StatelessWidget {
  final String title;
  final String date;
  final String soldTickets;
  final String totalTickets;

  CreatorEventCard(
      {required this.title,
      required this.date,
      required this.soldTickets,
      required this.totalTickets});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                ),
              ),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "$soldTickets/$totalTickets",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
