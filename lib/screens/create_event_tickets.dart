import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../requests/routes_api.dart';
import 'login_screen.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreateEventTickets extends StatefulWidget {
  static const routeName = '/tickets';
  final String eventID;

  const CreateEventTickets({Key? key, required this.eventID}) : super(key: key);

  @override
  CreateEventTicketsState createState() => CreateEventTicketsState();
}

int notEmpty = 0;

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

class CreateEventTicketsState extends State<CreateEventTickets> {
  String? _eventID;
  late String
      token; //='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDNjNGI0NjY0MzA0ODg2YWNkNDM1YzMiLCJpYXQiOjE2ODMyMzgzMDIsImV4cCI6MTY4MzMyNDcwMn0.rSsGJH5t5RXfzMavpxRxk2V3853FzWcB2rXzHWio-OA';

  @override
  void initState() {
    super.initState();
    _eventID = widget.eventID;
    print(_eventID);
    token = Provider.of<UserProvider>(context, listen: false)
        .token!; // initialize token in initState
    print(token);
  }

  //can add dummy data
  final List<TicketClass> _ticketClasses = [];

  void _addTicketClass() async {
    final result = await showDialog<TicketClass>(
      context: context,
      builder: (context) => ticketFormPopup(),
    );
    if (result != null) {
      setState(() {
        _ticketClasses.add(result);
        notEmpty = 1;
      });
    }
  }

  Future<void> sendRequest() async {
    for (var i = 0; i < _ticketClasses.length; i++) {
      final ticketClass = _ticketClasses[i];
      //print(
      //'${ticketClass.name}, ${ticketClass.type}, ${ticketClass.capacity}, ${ticketClass.price}, ${ticketClass.minQuantityPerOrder}, ${ticketClass.maxQuantityPerOrder}, ${ticketClass.sellingStartDate}, ${ticketClass.sellingEndDate}');
      final url = Uri.parse(
          '${RoutesAPI.getAllTickets}ticket/${_eventID}/createTicket');
      print(url);
      final body = <String, dynamic>{
        'name': ticketClass.name.toString(),
        'type': ticketClass.type.toString(),
        'price': ticketClass.price,
        'capacity': ticketClass.capacity,
        'minQuantityPerOrder': ticketClass.minQuantityPerOrder,
        'maxQuantityPerOrder': ticketClass.maxQuantityPerOrder,
        'salesStart': ticketClass.sellingStartDate.toString(),
        'salesEnd': ticketClass.sellingEndDate.toString(),
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode != 201) {
        print('Failed');
        final jsonResponse = json.decode(response.body);
        print('${jsonResponse['message']}');
      } else {
        print('successed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Manage Event Tickets'),
        ),
        body: ListView.builder(
          itemCount: _ticketClasses.length,
          itemBuilder: (context, index) {
            final ticket = _ticketClasses[index];
            return Card(
              child: ListTile(
                title: Text(ticket.name),
                subtitle: Text(
                    '${ticket.type} tickets, Price: \$${ticket.price}, Capacity: ${ticket.capacity}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _ticketClasses.removeAt(index);
                    });
                  },
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTicketClass,
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 227, 89, 4),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 300.0, bottom: 20),
            child: InkWell(
              onTap: () {
                if (notEmpty == 1) {
                  sendRequest().then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  }).catchError((error) {
                    print(error);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('An error occured try again!'),
                      ),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Press the + button and enter at least one type of tickets to continue creating your event!',
                      ),
                    ),
                  );
                }
              },
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 227, 89, 4),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            )));
  }
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
        _priceController.text = '0';
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
                  padding: EdgeInsets.only(right: 160, top: 3.5),
                  child: Text('Tickets Type:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Padding(
                      padding: EdgeInsets.only(right: 100, left: 20),
                      child: ElevatedButton(
                        onPressed: () => _selectTicketType('Free'),
                        child: Text('Free'),
                        style: ElevatedButton.styleFrom(
                          primary: _ticketType == 'Free'
                              ? Color.fromARGB(255, 210, 85, 7)
                              : Color.fromARGB(255, 144, 141, 140),
                        ),
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
