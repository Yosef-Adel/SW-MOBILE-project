///This is the screen that is displayed when the user clicks on the url sent in the email after they forgot their password.
///The screen contains a text field that takes a new password as input.
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'tabs_screen.dart';
import 'dart:convert';

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

            //Sign in button takes us to TabScreen
            const SizedBox(height: 150),
            SizedBox(
              width: 200, // set the width of the button
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final password = _passwordController.text;
                    try {
                      final response = await http.post(
                        Uri.parse(
                            "https://sw-backend-project.vercel.app/auth/reset-password/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDM4OWM1NDcwOGQwZDIzYmRlZTA4ZDciLCJpYXQiOjE2ODE0NDQxMjEsImV4cCI6MTY4MTUzMDUyMX0.ey8UMn6EONA8uE-eyu3luFnbqMldzNxqjKOZ78QI75I"),
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode(password),
                      );

                      if (response.statusCode == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TabsScreen(),
                          ),
                        );
                      } else {
                        print('error');
                      }
                    } catch (error) {
                      print('Error while logining in: $error');
                      throw 'Failed to login';
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
