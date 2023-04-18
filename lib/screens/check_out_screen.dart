import 'package:envie_cross_platform/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/ticket_provider.dart';
import '../widgets/app_bar.dart';
import '../models/ticket.dart';
import '../requests/routes_api.dart';
import 'dart:convert';
import '../providers/user_provider.dart';

class CheckOutScreen extends StatefulWidget {
  static const routeName = '/check-out';

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();

  Future<bool> placeOrder(
      {required String firstname,
      required String lastname,
      required String email,
      required List<Ticket> tickets,
      required String eventId,
      String? token,
      required String promoCodeId}) async {
    final url = Uri.parse('${RoutesAPI.placeOrder}${eventId}');
    print(url);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var ticketsBought = [];
    print(tickets);

    for (int i = 0; i < tickets.length; ++i) {
      Map<String, dynamic> ticket = {};
      if (tickets[i].count > 0) {
        print(tickets[i].id);
        print(tickets[i].count);
        ticket["ticketClass"] = tickets[i].id;
        ticket['number'] = tickets[i].count;
        ticketsBought.add(ticket);
      }
    }
    var body;
    if (promoCodeId == null || promoCodeId.isEmpty) {
      body = json.encode({
        'ticketsBought': ticketsBought,
        'firstName': firstname,
        'lastName': lastname,
        'email': email
      });
    } else {
      body = json.encode({
        'ticketsBought': ticketsBought,
        'promocode': promoCodeId,
        'firstName': firstname,
        'lastName': lastname,
        'email': email
      });
    }

    print(body);

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      final jsonResponse = json.decode(response.body);
      final message = jsonResponse["message"];
      print(message);
      if (message == "Order created successfully!") {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error while placing order: $error');
      throw 'Failed to place order';
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateConfirmEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your email';
    }
    if (value != emailController.text) {
      return 'Emails do not match';
    }
    return null;
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    if (value.length < 2 || value.length > 20) {
      return 'Should be between 2 and 20 characters';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Should only contain letters';
    }
    return null;
  }

  String? validateSurName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your surname';
    }
    if (value.length < 2 || value.length > 20) {
      return 'Should be between 2 and 20 characters';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Should only contain letters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var ticketsProv = Provider.of<TicketsProvider>(context, listen: false);
    final eventTicketDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    var usrtoken = Provider.of<UserProvider>(context,listen: false).token;
    return Scaffold(
        appBar: MyAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 50,
          decoration: BoxDecoration(color: Colors.white),
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final bool orderPlaced = await placeOrder(
                    firstname: _firstNameController.text,
                    lastname: _surNameController.text,
                    email: emailController.text,
                    tickets: ticketsProv.allTickets,
                    eventId: eventTicketDetails['eventId']!,
                    token:
                        usrtoken,
                    promoCodeId: eventTicketDetails['promoCodeId']!);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: orderPlaced
                        ? Text('Order has been placed succesfully')
                        : Text('Order have not been placed due to an error')));
                if (orderPlaced) {
                  Future.delayed(Duration(seconds: 5), () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  });
                }
              }
            },
            child: const Center(
              child: Text('Register'),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //'Create an account' Container
                          Container(
                            alignment: Alignment.topLeft,
                            padding:
                                EdgeInsetsDirectional.only(top: 10, bottom: 30),
                            child: Text(
                              'Contact Information',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      labelText: 'First name *',
                                    ),
                                    validator: validateFirstName),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                    controller: _surNameController,
                                    decoration: InputDecoration(
                                      labelText: 'last name *',
                                    ),
                                    validator: validateSurName),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: emailValidator,
                          ),
                          SizedBox(height: 10),

                          TextFormField(
                              controller: _confirmEmailController,
                              decoration: InputDecoration(
                                labelText: 'Confirm Email *',
                              ),
                              validator: validateConfirmEmail),
                          SizedBox(height: 10),
                        ])))));
  }
}
