/// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'signup_screen.dart';
import 'tabs_screen.dart';
import 'update_password_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true; // added variable to track password visibility

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
          title: const Text('Eventbrite'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //'Let's get started' Container
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Let\'s get started',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //miniText Container
                  Container(
                    alignment: Alignment.topLeft,
                    padding:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 20),
                    child: const Text(
                      'Sign up or log in to see what\'s happening near you',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  //Text fields for entering email and passowrd
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: emailValidator,
                  ),

                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
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

                  //Forgot password gesture
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        final String email = _emailController.text;
                        final String? validationResult = emailValidator(email);
                        if (validationResult != null) {
                          // Show error message to the user
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(validationResult)),
                          );
                        } else {
                          //first using API send email then navigate to the UpdatePasswordScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePasswordScreen(
                                emailController: _emailController,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Login button
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushNamed(TabsScreen.routeName);
                        //Implement login API call
                      }
                    },
                    child: const Text('LOGIN'),
                  ),
                  const SizedBox(height: 20),

                  //'or' Seperator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 10,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 10,
                        ),
                      ),
                    ],
                  ),

                  //Sign in with Google Buttton
                  SignInButton(
                    Buttons.Google,
                    text: "Continue with Google",
                    onPressed: () async {
                      //Google sign in logic
                      GoogleSignIn googleSignIn = GoogleSignIn();
                      GoogleSignInAccount? account =
                          await googleSignIn.signIn();
                      if (account != null) {
                        // Successful Google sign in
                        Navigator.of(context).pushNamed(TabsScreen.routeName);

                        //Implement login API call
                      } else {
                        // Failed Google sign in
                      }
                    },
                  ),
                  //const SizedBox(height: 10),

                  //Sign in with Facebook Buttton
                  SignInButton(Buttons.Facebook, text: "Continue with Facebook",
                      onPressed: () async {
                    const url = 'https://facebook.com';
                    launch(url);
                    //Facebook sign in logic (API)
                    //LoginResult result = await FacebookAuth.instance.login();
                    //if (result.status == LoginStatus.success) {
                    // Successful Facebook sign in
                    //String token = result.accessToken!.token;
                    //Navigator.of(context).pushNamed(TabsScreen.routeName);
                    //} else {
                    // Failed Facebook sign in
                    //}
                  }),

                  //Don't have an account? Sign up! Gesture
                  //Loads us to Sign up screen
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(SignupScreen.routeName),
                    child: const Text(
                      'Don\'t have an account? Sign up!',
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
        ));
  }
}
