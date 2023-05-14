/// This screen is used to add tickets to an attendee by the creator.

import 'package:envie_cross_platform/providers/ticket_provider.dart';
import 'package:envie_cross_platform/screens/creator_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ticket.dart';
import '../providers/creator_event_provider.dart';
import '../widgets/tickets_list_widget.dart';
import 'creator_checkout_screen.dart';

class ManageAttendees extends StatefulWidget {
  static const routeName = '/manage-attendees';

  @override
  State<ManageAttendees> createState() => _ManageAttendees();
}

class _ManageAttendees extends State<ManageAttendees> {
  void goToCheckOutScreen(BuildContext ctx, String eventId, String promoCode) {
    Navigator.of(ctx).pushNamed(ManageAttendeesCheckout.routeName,
        arguments: {'eventId': eventId, 'promoCodeId': promoCode});
  }

  double calcTotalPrice(List<Ticket> tickets) {
    double sum = 0;
    for (int i = 0; i < tickets.length; ++i) {
      sum += tickets[i].price;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final ticketsData =
        Provider.of<TicketsProvider>(context, listen: false).allTickets;
    final countTickets = Provider.of<TicketsProvider>(context).count;
    String eventID = Provider.of<CreatorEventProvider>(context, listen: false)
        .selectedEventId!;
    var totalPrice = calcTotalPrice(ticketsData);
    return Scaffold(
        drawer: CreatorDrawer(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 1),
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text(
            "Select ticket type",
            style: TextStyle(
              fontFamily: 'Nexa',
              fontSize: 30,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: TicketInfo(eventID),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 221, 200, 200))),
          child: Padding(
            padding: EdgeInsets.only(left: 150.0, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.white),
                    margin: const EdgeInsets.all(10),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          //print(countTickets);
                          if (countTickets > 0) {
                            goToCheckOutScreen(context, eventID, "");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('There are no tickets selected')));
                          }
                        },
                        child: const Center(
                          child: Text('Continue'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
