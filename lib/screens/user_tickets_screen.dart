import 'package:flutter/material.dart';

class UserTickets extends StatelessWidget {
  const UserTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 30.0),
        child: Column(
          children: [
            Text('Tickets',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40)),
          ],
        ),
      ),
    );
  }
}
