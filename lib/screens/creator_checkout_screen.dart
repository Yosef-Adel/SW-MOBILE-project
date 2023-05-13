import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ticket_provider.dart';
import '../providers/user_provider.dart';
import '../requests/creator_place_order_api.dart';
import '../widgets/app_bar.dart';
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
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$');
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
                final bool orderPlaced = await creatorPlaceOrder(
                    firstname: widget._firstNameController.text,
                    lastname: widget._surNameController.text,
                    email: widget.emailController.text,
                    tickets: ticketsProv.allTickets,
                    eventId: eventTicketDetails['eventId']!,
                    token: usrtoken,
                    userId: userId!);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: orderPlaced
                        ? Text('Added attendee successfully!')
                        : Text('Failed to add attendee')));
                if (orderPlaced) {
                  Provider.of<TicketsProvider>(context, listen: false).count =
                      0;
                  Future.delayed(Duration(seconds: 1), () {
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
                                      labelText: 'Last name *',
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
