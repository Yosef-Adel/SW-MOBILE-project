import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../requests/routes_api.dart';
import 'login_screen.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreateEventPromocodes extends StatefulWidget {
  static const routeName = '/promocodes';
  String eventID = "";

  @override
  CreateEventPromocodesState createState() => CreateEventPromocodesState();
}

class PromocodeClass {
  String name;
  //String tickets;
  int percentOff;
  int amountOff;
  DateTime startDate;
  DateTime endDate;

  PromocodeClass({
    required this.name,
    //required this.tickets,
    required this.percentOff,
    required this.amountOff,
    required this.startDate,
    required this.endDate,
  });
}

class CreateEventPromocodesState extends State<CreateEventPromocodes> {
  

  late String token;

  @override
  void initState() {
    super.initState();
    // token = Provider.of<UserProvider>(context, listen: false)
    //     .token!; // initialize token in initState
    // print(token);
  }

  //can add dummy data
  final List<PromocodeClass> _PromocodeClasses = [];

  void _addPromocodeClass() async {
    final result = await showDialog<PromocodeClass>(
      context: context,
      builder: (context) => promocodeFormPopup(),
    );
    if (result != null) {
      setState(() {
        _PromocodeClasses.add(result);
      });
    }
  }

  // Future<void> sendRequest() async {
  //   for (var i = 0; i < _PromocodeClasses.length; i++) {
  //     final PromocodeClass = _PromocodeClasses[i];
  //     //print(
  //     //'${PromocodeClass.name}, ${PromocodeClass.type}, ${PromocodeClass.capacity}, ${PromocodeClass.price}, ${PromocodeClass.minQuantityPerOrder}, ${PromocodeClass.maxQuantityPerOrder}, ${PromocodeClass.startDate}, ${PromocodeClass.endDate}');
  //     final url = Uri.parse(
  //         '${RoutesAPI.getAllTickets}ticket/${_eventID}/createTicket');
  //     print(url);

  //     final Map<String, dynamic> body;

  //     if (PromocodeClass.amountOff == 0) {
  //       //'${PromocodeClass.name}, ${PromocodeClass.type}, ${PromocodeClass.capacity}, ${PromocodeClass.price}, ${PromocodeClass.minQuantityPerOrder}, ${PromocodeClass.maxQuantityPerOrder}, ${PromocodeClass.startDate}, ${PromocodeClass.endDate}');
  //       body = <String, dynamic>{
  //         'name': PromocodeClass.name.toString(),
  //         //'tickets': PromocodeClass.type.toString(),
  //         'percentOff': PromocodeClass.percentOff,
  //         'startDate': PromocodeClass.startDate.toString(),
  //         'endDate': PromocodeClass.endDate.toString(),
  //       };
  //     } else {
  //       //'${PromocodeClass.name}, ${PromocodeClass.type}, ${PromocodeClass.capacity}, ${PromocodeClass.price}, ${PromocodeClass.minQuantityPerOrder}, ${PromocodeClass.maxQuantityPerOrder}, ${PromocodeClass.startDate}, ${PromocodeClass.endDate}');
  //       body = <String, dynamic>{
  //         'name': PromocodeClass.name.toString(),
  //         //'tickets': PromocodeClass.type.toString(),
  //         'amountOff': PromocodeClass.amountOff,
  //         'startDate': PromocodeClass.startDate.toString(),
  //         'endDate': PromocodeClass.endDate.toString(),
  //       };
  //     }
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //     final response =
  //         await http.post(url, headers: headers, body: jsonEncode(body));
  //     if (response.statusCode != 201) {
  //       print('Failed');
  //       final jsonResponse = json.decode(response.body);
  //       print('${jsonResponse['message']}');
  //     } else {
  //       print('successed');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    widget.eventID = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: Text('Manage Event Promo Codes'),
        ),
        body: ListView.builder(
          itemCount: _PromocodeClasses.length,
          itemBuilder: (context, index) {
            final promocode = _PromocodeClasses[index];
            return Card(
              child: ListTile(
                title: Text(promocode.name),
                subtitle: promocode.amountOff == 0
                    ? Text('Gives ${promocode.percentOff}% off')
                    : Text('Gives \$${promocode.amountOff} off'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _PromocodeClasses.removeAt(index);
                    });
                  },
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addPromocodeClass,
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 227, 89, 4),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 322.0, bottom: 20),
            child: InkWell(
              onTap: () {
                // sendRequest().then((_) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => LoginScreen(),
                //     ),
                //   );
                // }).catchError((error) {
                //   print(error);

                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text('An error occured try again!'),
                //     ),
                //   );
                // });
              },
              child: Container(
                width: 54.0,
                height: 54.0,
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

class promocodeFormPopup extends StatefulWidget {
  const promocodeFormPopup({super.key});

  @override
  promocodeFormPopupState createState() => promocodeFormPopupState();
}

class promocodeFormPopupState extends State<promocodeFormPopup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  //final _chosenTicketsController = TextEditingController();
  late String? _selectedOption = '';
  late var _amountOffController = TextEditingController();
  var _percentOffController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  // void dispose() {
  //   _amountOffController.dispose();
  //   _percentOffController.dispose();
  //   super.dispose();
  // }

  void _savePromocode() {
    final name = _nameController.text;
    //final tickets = _chosenTicketsController;
    final amountOff = int.parse(_amountOffController.text);
    final percentOff = int.parse(_percentOffController.text);
    final startDate = DateTime.parse(_startDateController.text);
    final endDate = DateTime.parse(_endDateController.text);
    final promocode = PromocodeClass(
      name: name,
      //tickets: tickets,
      percentOff: percentOff,
      amountOff: amountOff,
      startDate: startDate,
      endDate: endDate,
    );

    Navigator.of(context).pop(promocode);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add Promo code'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Code',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a code';
                    }
                    return null;
                  },
                ),
                Column(
                  children: [
                    DropdownButtonFormField(
                      value: _selectedOption,
                      items: [
                        DropdownMenuItem(
                          child: Text('Amount'),
                          value: 'amount',
                        ),
                        DropdownMenuItem(
                          child: Text('Percent'),
                          value: '',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                    TextFormField(
                      controller: _selectedOption == 'amount'
                          ? (_amountOffController)
                          : (_percentOffController),
                      decoration: InputDecoration(
                        labelText: _selectedOption == 'amount'
                            ? 'Amount off (\$)'
                            : 'Percent off (%)',
                        suffixIcon: _selectedOption == 'amount'
                            ? Icon(Icons.attach_money)
                            : Icon(Icons.percent),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid integer value';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter a value greater than zero';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                TextFormField(
                  controller: _startDateController,
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
                        _startDateController.text = date.toString();
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
                  controller: _endDateController,
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
                        _endDateController.text = date.toString();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _selectedOption = '';
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_selectedOption == 'amount') {
                            _percentOffController.text = '0';
                          } else {
                            _amountOffController.text = '0';
                          }
                          _selectedOption = '';
                          _savePromocode();
                        }
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
