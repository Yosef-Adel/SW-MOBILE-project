import 'package:envie_cross_platform/screens/creator_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../requests/creator_create_ticket_api.dart';

class editTicketFormPopUp extends StatefulWidget {
  final String ticketId;
  const editTicketFormPopUp({required this.ticketId});

  @override
  State<editTicketFormPopUp> createState() => _ticketFormPopupState();
}

class _ticketFormPopupState extends State<editTicketFormPopUp> {
  final _formKey = GlobalKey<FormState>();

  String _ticketType = 'Paid';

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  void _editTicket(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      double price = double.parse(_priceController.text);
      print(price);

      int result =
          await creatorEditTicket(context, name, price, widget.ticketId);
      if (result == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ticket edited successfully')));
        Navigator.of(context).pushReplacementNamed(CreatorTickets.routeName);
      } else
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error while editing ticket')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Edit Ticket'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Ticket Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name for the ticket.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price \$',
                  ),
                  keyboardType: TextInputType.number,
                  enabled: _ticketType != 'Free',
                  validator: (value) {
                    if ((value == null || value.isEmpty)) {
                      return 'Please enter a price for the ticket.';
                    }
                    if (double.parse(value) <= 0 && _ticketType != 'Free') {
                      return 'Enter a number more than 0 or choose Free';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _editTicket(context),
                      child: Text('Edit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
