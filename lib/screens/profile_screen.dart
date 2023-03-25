import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(height: 55),
                Text('Log in to discover the best events',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text('When you sign in, you can see our top picks for you',
                    style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.routeName),
              child: Text('Log in'),
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size.fromWidth(MediaQuery.of(context).size.width * 0.9),
              ),
            ),
          )
        ]);
  }
}
