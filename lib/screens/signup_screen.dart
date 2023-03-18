// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'login_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //'Create an account' Container
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsetsDirectional.only(top: 10, bottom: 50),
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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 10),

            //Confirm email text field
            TextField(
              controller: _confirmEmailController,
              decoration: InputDecoration(
                labelText: 'Confirm Email *',
              ),
            ),
            SizedBox(height: 10),

            //Row containing First Name and Sur Name text fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First name *',
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _surNameController,
                    decoration: InputDecoration(
                      labelText: 'Surname *',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            //Password text field
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
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
                'Password must have atleast 8 characters.',
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
                if (_emailController.text != _confirmEmailController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Emails don't match"),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  //Implement signup API call
                }
              },
              child: Text('SIGN UP'),
            ),
            SizedBox(height: 10),

            //Already have an account? Login! Gesture
            //Loads us to login screen
            // GestureDetector(
            //   onTap: () =>
            //       Navigator.of(context).pushNamed(LoginScreen.routeName),
            //   child: Text(
            //     'Already have an account? Login!',
            //     style: TextStyle(
            //       color: Colors.blue,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
