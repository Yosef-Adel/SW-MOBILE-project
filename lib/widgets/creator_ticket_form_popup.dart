import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

//tickets class
class TicketClass {
  String name;
  String type;
  double price;
  int capacity;
  int minQuantityPerOrder;
  int maxQuantityPerOrder;
  DateTime sellingStartDate;
  DateTime sellingEndDate;

  TicketClass({
    required this.name,
    required this.type,
    required this.capacity,
    required this.price,
    required this.minQuantityPerOrder,
    required this.maxQuantityPerOrder,
    required this.sellingStartDate,
    required this.sellingEndDate,
  });
}

class ticketFormPopup extends StatefulWidget {
  const ticketFormPopup({super.key});

  @override
  ticketFormPopupState createState() => ticketFormPopupState();
}

class ticketFormPopupState extends State<ticketFormPopup> {
  final _formKey = GlobalKey<FormState>();

  String _ticketType = 'Paid'; //holds ticketType
  bool _isTicketTypeSelected = false;

  final _nameController = TextEditingController();
  final _capacityController = TextEditingController();
  final _priceController = TextEditingController();
  final _maxQuantityController = TextEditingController();
  final _sellingStartDateController = TextEditingController();
  final _sellingEndDateController = TextEditingController();

  void _selectTicketType(String type) {
    setState(() {
      _ticketType = type;
      _isTicketTypeSelected = true;

      if (type == 'Free') {
        _priceController.text = '1';
        _priceController.clearComposing();
      }
    });
  }

  void _saveTicket() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final capacity = int.parse(_capacityController.text);
      final price = double.parse(_priceController.text);
      final sellingStartDate = DateTime.parse(_sellingStartDateController.text);
      final sellingEndDate = DateTime.parse(_sellingEndDateController.text);
      final ticket = TicketClass(
        name: name,
        type: _ticketType,
        capacity: capacity,
        price: price,
        minQuantityPerOrder: 1,
        maxQuantityPerOrder: capacity,
        sellingStartDate: sellingStartDate,
        sellingEndDate: sellingEndDate,
      );

      Navigator.of(context).pop(ticket);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add Tickets'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Tickets Name',
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
                    'Tickets Type:',
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
                            ? Color.fromARGB(255, 210, 85, 7)
                            : Color.fromARGB(255, 144, 141, 140),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTicketType('Free'),
                      child: Text('Free'),
                      style: ElevatedButton.styleFrom(
                        primary: _ticketType == 'Free'
                            ? Color.fromARGB(255, 210, 85, 7)
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price for the ticket.';
                    }
                    if (int.parse(value) <= 0) {
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
                      onPressed: () {
                        _saveTicket();
                      },
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
