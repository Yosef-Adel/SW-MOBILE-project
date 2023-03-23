// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'tabs_screen.dart';

// ignore: use_key_in_widget_constructors
class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true; // added variable to track password visibility
  final _formKey = GlobalKey<FormState>();

  //Email validation function (to check that it's not empty and in the right format)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
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
                  padding: EdgeInsetsDirectional.only(top: 10, bottom: 30),
                  child: Text(
                    'Create an account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //Email text field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: emailValidator,
                ),
                SizedBox(height: 10),

                //Confirm email text field
                TextFormField(
                  controller: _confirmEmailController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Email *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your email';
                    }
                    if (value != _emailController.text) {
                      return 'Emails do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                //Row containing First Name and Sur Name text fields
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First name *',
                        ),
                        validator: (value) {
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
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _surNameController,
                        decoration: InputDecoration(
                          labelText: 'Surname *',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your surname';
                          }
                          if (value.length < 2 || value.length > 15) {
                            return 'Should be between 2 and 20 characters';
                          }
                          if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return ' Should only contain letters';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                //Password text field
                TextFormField(
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
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password must have at least 8 characters.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'A verification email has been sent to your email address. Please click on the link to verify your account.'),
                          duration: Duration(seconds: 5),
                        ),
                      );

                      // Wait for 5 seconds before navigating to the TabsScreen route
                      //when we integrate with backend we don't navigate to TabsScreen unless email link is pressed and verified
                      Future.delayed(Duration(seconds: 5), () {
                        Navigator.of(context).pushNamed(TabsScreen.routeName);
                      });
                    } else {
                      //Implement signup API call
                    }
                  },
                  child: Text('SIGN UP'),
                ),

                SizedBox(height: 10),

                //Already have an account? Login! Gesture
                //Loads us to login screen
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(LoginScreen.routeName),
                  child: Text(
                    'Already have an account? Login!',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
