import 'package:flutter/material.dart';
import 'tabs_screen.dart';

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
            Image.asset(
              'assets/images/UserIcon.jpg',
              height: 150,
              width: 150,
            ),

            //New password field
            const SizedBox(height: 150),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TabsScreen(),
                        ));

                    //Implement API so that backend takes new password saved in _passwordController
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
