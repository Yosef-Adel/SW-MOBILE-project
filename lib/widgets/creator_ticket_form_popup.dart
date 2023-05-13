/// This file contains the popup form for creating a ticket. It contains the form fields and the methods to save the ticket.

import 'package:envie_cross_platform/screens/creator_events_screen.dart';
import 'package:envie_cross_platform/screens/creator_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

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
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  void _selectTicketType(String type) {
    setState(() {
      _ticketType = type;

      if (type == 'Free') {
        _priceController.text = '0';
      }
    });
  }

  String? dateRangeValidator() {
    if (_sellingStartDateController.text.isNotEmpty &&
        _sellingEndDateController.text.isNotEmpty) {
      DateTime startDate = DateTime.parse(_startDateController.text);
      DateTime endDate = DateTime.parse(_endDateController.text);
      if (startDate.isAfter(endDate)) {
        return 'Start date must be before end date';
      }
    }
    return null;
  }

  void _saveTicket(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final capacity = int.parse(_capacityController.text);
      final price = double.parse(_priceController.text);
      final maxQuantityPerOrder = int.parse(_maxQuantityController.text);
      final sellingStartDate = DateTime.parse(_startDateController.text);
      final sellingEndDate = DateTime.parse(_endDateController.text);

      int result = await creatorAddTicket(context, name, _ticketType, capacity,
          price, maxQuantityPerOrder, sellingStartDate, sellingEndDate);
      if (result == 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Ticket added successfully')));
        Navigator.of(context).pushReplacementNamed(CreatorEvents.routeName);
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
                    var numRegex = RegExp(r'^[0-9]*$');
                    if (!numRegex.hasMatch(value)) {
                      return 'Please enter a number';
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
                    var numRegex = RegExp(r'^[0-9]*$');
                    if (!numRegex.hasMatch(value)) {
                      return 'Please enter a number';
                    }
                    if (double.parse(value) <= 0 && _ticketType != 'Free') {
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
                        _sellingStartDateController.text =
                            DateFormat('yyyy-MM-dd hh:mm a')
                                .format(date)
                                .toString();
                        _startDateController.text = date.toString();
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  validator: (value) {
                    String? dateRangeError = dateRangeValidator();
                    if (dateRangeError != null) {
                      return dateRangeError;
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
                        _sellingEndDateController.text =
                            DateFormat('yyyy-MM-dd hh:mm a')
                                .format(date)
                                .toString();
                        _endDateController.text = date.toString();
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  validator: (value) {
                    String? dateRangeError = dateRangeValidator();
                    if (dateRangeError != null) {
                      return dateRangeError;
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
