///This is the screen that is displayed when the user clicks on the url sent in the email after they forgot their password.
///The screen contains a text field that takes a new password as input.
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'tabs_screen.dart';
import 'dart:convert';
import '../requests/routes_api.dart';

class CreatePasswordScreen extends StatefulWidget {
  static const routeName = '/createPassword';

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true; // added variable to track password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //image of profile
            const SizedBox(height: 10),
            Icon(
              Icons.person,
              color: Colors.grey,
              size: 100,
            ),

            //New password field
            const SizedBox(height: 100),
            Form(
                key: _formKey,
                child:
                    // New password field
                    Container(
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                      ),
                    ),
                    obscureText:
                        _isPasswordHidden, // added option to hide/show password
                  ),
                  padding: EdgeInsets.all(10),
                )),

            //Enter new password button
            const SizedBox(height: 150),
            SizedBox(
              width: 200, // set the width of the button
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final password = _passwordController.text;
                    try {
                      // final url = Uri.parse(
                      //     '${RoutesAPI.createNewPassword}/${Provider.of<UserProvider>(context, listen: false).token}');
                      //should replace with token from url
                      String token =
                          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDM4OWM1NDcwOGQwZDIzYmRlZTA4ZDciLCJpYXQiOjE2ODE1ODM5MzcsImV4cCI6MTY4MTY3MDMzN30.43tt2jmaViH7gnXP1sb3r4oSznOKMofXG10jKxPiVG0';
                      final url =
                          Uri.parse('${RoutesAPI.createNewPassword}/$token');

                      final headers = {'Content-Type': 'application/json'};
                      final body = jsonEncode({'password': password});
                      final response = await http.patch(
                        url,
                        headers: headers,
                        body: body,
                      );
                      final jsonResponse = json.decode(response.body);
                      final message = jsonResponse['message'];
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Password is changed successfully')),
                        );
                        // Wait for 5 seconds before navigating to the Login route
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.of(context)
                              .pushReplacementNamed(TabsScreen.routeName);
                        });
                      } else {
                        //logout cuz token expired
                      }
                    } catch (error) {
                      print('Error while logining in: $error');
                      throw 'Failed to reach server maybe wrong url';
                    }
                  }
                },
                child: const Text('Sign in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
