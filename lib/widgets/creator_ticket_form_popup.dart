import 'package:envie_cross_platform/screens/creator_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../requests/creator_create_ticket_api.dart';

class ticketFormPopup extends StatefulWidget {
  const ticketFormPopup({super.key});

  @override
  ticketFormPopupState createState() => ticketFormPopupState();
}

class ticketFormPopupState extends State<ticketFormPopup> {
  final _formKey = GlobalKey<FormState>();

  String _ticketType = 'Paid';

  final _nameController = TextEditingController();
  final _capacityController = TextEditingController();
  final _priceController = TextEditingController();
  final _maxQuantityController = TextEditingController();
  final _sellingStartDateController = TextEditingController();
  final _sellingEndDateController = TextEditingController();

  void _selectTicketType(String type) {
    setState(() {
      _ticketType = type;

      if (type == 'Free') {
        _priceController.text = '0';
      }
    });
  }

  void _saveTicket(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final capacity = int.parse(_capacityController.text);
      final price = double.parse(_priceController.text);
      final maxQuantityPerOrder = int.parse(_maxQuantityController.text);
      final sellingStartDate = DateTime.parse(_sellingStartDateController.text);
      final sellingEndDate = DateTime.parse(_sellingEndDateController.text);

      int result = await creatorAddTicket(context, name, _ticketType, capacity,
          price, maxQuantityPerOrder, sellingStartDate, sellingEndDate);
      if (result == 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Ticket added successfully')));
        Navigator.of(context).pushReplacementNamed(CreatorTickets.routeName);
      } else
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error while adding ticket')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add Ticket'),
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
                Padding(
                  padding: const EdgeInsets.only(right: 120, top: 8),
                  child: Text(
                    'Ticket Type:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectTicketType('Paid'),
                      child: Text('Paid'),
                      style: ElevatedButton.styleFrom(
                        primary: _ticketType == 'Paid'
                            ? Theme.of(context).primaryColor
                            : Color.fromARGB(255, 144, 141, 140),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTicketType('Free'),
                      child: Text('Free'),
                      style: ElevatedButton.styleFrom(
                        primary: _ticketType == 'Free'
                            ? Theme.of(context).primaryColor
                            : Color.fromARGB(255, 144, 141, 140),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _capacityController,
                  decoration: InputDecoration(
                    labelText: 'Capacity',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a capacity for the ticket.';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Please enter a number more than 0';
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
                    if (int.parse(value) <= 0 && _ticketType != 'Free') {
                      return 'Enter a number more than 0 or choose Free';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sellingStartDateController,
                  decoration: InputDecoration(
                    labelText: 'Selling Start Date',
                  ),
                  onTap: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2100, 12, 31),
                      onChanged: (date) {
                        _sellingStartDateController.text = date.toString();
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a selling start date.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sellingEndDateController,
                  decoration: InputDecoration(
                    labelText: 'Selling End Date',
                  ),
                  onTap: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2100, 12, 31),
                      onChanged: (date) {
                        _sellingEndDateController.text = date.toString();
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an ending start date.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _maxQuantityController,
                  decoration: InputDecoration(
                    labelText: 'Maximum Quantity per Order',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a maximum quantity per order.';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Please enter a number more than 0';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _saveTicket(context),
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
