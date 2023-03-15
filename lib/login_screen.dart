// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../signup_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventbrite'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //'Let's get started' Container
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsetsDirectional.only(top: 20, bottom: 10),
              child: Text(
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
              padding: EdgeInsetsDirectional.only(bottom: 50, end: 100),
              child: Text(
                'Sign up or log in to see what\'s happening near you',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),

            //Text fields for entering email and passowrd
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //Implement login API call
              },
              child: Text('LOGIN'),
            ),
            SizedBox(height: 20),

            //'or' Seperator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 10,
                  ),
                ),
              ],
            ),

            //Sign in with Google Buttton
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton.icon(
                onPressed: () async {
                  //Google sign in logic
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  GoogleSignInAccount? account = await googleSignIn.signIn();
                  if (account != null) {
                    // Successful Google sign in
                  } else {
                    // Failed Google sign in
                  }
                },
                icon: Image.asset('assets/images/Google.png', height: 24),
                label: Text('Continue with Google'),
              ),
            ),
            SizedBox(height: 10),

            //Sign in with Facebook Buttton
            SizedBox(
              width: 300,
              child: ElevatedButton.icon(
                onPressed: () async {
                  //Facebook sign in logic (API)
                  LoginResult result = await FacebookAuth.instance.login();
                  if (result.status == LoginStatus.success) {
                    // Successful Facebook sign in
                    String token = result.accessToken!.token;
                  } else {
                    // Failed Facebook sign in
                  }
                },
                icon: Image.asset('assets/images/Facebook.jpg', height: 24),
                label: Text('Continue with Facebook'),
              ),
            ),

            //Don't have an account? Sign up! Gesture
            //Loads us to Sign up screen
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                );
              },
              child: Text(
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
    );
  }
}
