import 'package:envie_cross_platform/screens/creator_promocodes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ticket.dart';
import '../providers/creator_event_provider.dart';
import '../requests/creator_delete_ticket_api.dart';
import '../requests/creator_get_all_tickets_api.dart';
import '../widgets/creator_ticket_form_popup.dart';
import '../widgets/loading_indicator.dart';
import 'creator_drawer.dart';
import '../widgets/creator_edit_ticket_Popup.dart';

class CreatorTickets extends StatelessWidget {
  static const routeName = '/creator-tickets';

  void _addCreatorTicket(BuildContext context) async {
    await showDialog<Ticket>(
      context: context,
      builder: (_) => ticketFormPopup(),
    );
  }

  void _editCreatorTicket(BuildContext context, String ticId) async {
    await showDialog(
        context: context, builder: (_) => editTicketFormPopUp(ticketId: ticId));
  }

  @override
  Widget build(BuildContext context) {
    final eventID = Provider.of<CreatorEventProvider>(context, listen: false)
        .selectedEventId!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'promocodes') {
                Navigator.of(context)
                    .pushReplacementNamed(CreatorPromocodes.routeName);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'promocodes',
                child: Text('Promocodes'),
              ),
            ],
          ),
        ],
      ),
      drawer: CreatorDrawer(),
      floatingActionButton: FloatingActionButton(
        heroTag: "Add Ticket Button",
        onPressed: () => _addCreatorTicket(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
        future: creatorGetAllTickets(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          } else if (snapshot.data != null &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final ticket = snapshot.data[index];
                print(snapshot.data[index].id);
                return Card(
                  child: ListTile(
                    title: Text(ticket.name),
                    subtitle: ticket.type == 'Paid'
                        ? Text(
                            '${ticket.type}, Price: \$${ticket.price}, Capacity: ${ticket.capacity}')
                        : Text('${ticket.type}, Capacity: ${ticket.capacity}'),
                    trailing: Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                int result = await creatorDeleteTicket(
                                    context, ticket.id);
                                if (result == 0)
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Success'),
                                      content:
                                          Text('Ticket deleted successfully'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .pushReplacementNamed(
                                                  CreatorTickets.routeName),
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                              }),
                          SizedBox(width: 8),

                          // edit ticket
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () =>
                                  _editCreatorTicket(context, ticket.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No tickets found!', style: TextStyle(fontSize: 20)),
            );
          }
        },
      ),
    );
  }
}
