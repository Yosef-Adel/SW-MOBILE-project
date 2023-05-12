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
import 'creator_show_basic_info.dart';

class ManageAttedneesCheckout extends StatefulWidget {
  static const routeName = '/manage-attendees-check-out';
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();

  @override
  State<ManageAttedneesCheckout> createState() => _ManageAttedneesCheckout();

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
}

class _ManageAttedneesCheckout extends State<ManageAttedneesCheckout> {
  final _formKey = GlobalKey<FormState>();

  Future<bool> placeOrder(
      {required String firstname,
      required String lastname,
      required String email,
      required List<Ticket> tickets,
      required String eventId,
      String? token,
      required String userId}) async {
    final url = Uri.parse(
        '${RoutesAPI.creatorGetEvents}/${eventId}/${userId}/attendees');
    print(url);
    //print(token);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var ticketsBought = [];

    for (int i = 0; i < tickets.length; ++i) {
      Map<String, dynamic> ticket = {};
      if (tickets[i].count > 0) {
        //print(tickets[i].id);
        //print(tickets[i].count);
        ticket["ticketClass"] = tickets[i].id;
        ticket["faceValue"] = "5";
        ticket['number'] = tickets[i].count;
        ticketsBought.add(ticket);
      }
    }
    var body;
    body = json.encode({
      'ticketsBought': ticketsBought,
      'firstName': firstname,
      'lastName': lastname,
      'email': email
    });
    print(body);

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      final jsonResponse = json.decode(response.body);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error while placing order: $error');
      throw 'Failed to place order';
    }
  }

  @override
  Widget build(BuildContext context) {
    var ticketsProv = Provider.of<TicketsProvider>(context, listen: false);
    String? userId = Provider.of<UserProvider>(context, listen: false).user.id;
    final eventTicketDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    var usrtoken = Provider.of<UserProvider>(context, listen: false).token;
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
                    firstname: widget._firstNameController.text,
                    lastname: widget._surNameController.text,
                    email: widget.emailController.text,
                    tickets: ticketsProv.allTickets,
                    eventId: eventTicketDetails['eventId']!,
                    token: usrtoken,
                    userId: userId!);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: orderPlaced
                        ? Text('added attendee')
                        : Text('failed to add attendee')));
                if (orderPlaced) {
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.of(context)
                        .pushReplacementNamed(CreatorShowBasicInfo.routeName);
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
                                    controller: widget._firstNameController,
                                    decoration: InputDecoration(
                                      labelText: 'First name *',
                                    ),
                                    validator: widget.validateFirstName),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                    controller: widget._surNameController,
                                    decoration: InputDecoration(
                                      labelText: 'last name *',
                                    ),
                                    validator: widget.validateSurName),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          TextFormField(
                            controller: widget.emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: widget.emailValidator,
                          ),
                          SizedBox(height: 10),

                          TextFormField(
                              controller: widget._confirmEmailController,
                              decoration: InputDecoration(
                                labelText: 'Confirm Email *',
                              ),
                              validator: widget.validateConfirmEmail),
                          SizedBox(height: 100),
                        ])))));
  }
}
