import 'package:envie_cross_platform/screens/login_screen.dart';
import 'package:flutter/material.dart';

class UpdatePasswordScreen extends StatelessWidget {
  static const routeName = '/updatePassword';
  final TextEditingController emailController;

  const UpdatePasswordScreen({Key? key, required this.emailController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update your password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //For your security Text Message
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(17),
                    color: Color.fromARGB(255, 245, 245, 169),
                    child: Text(
                      'For your security, this link expires in 2 hours.',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            //Lock image
            Image.asset(
              'assets/images/Lock.png',
              height: 70,
              width: 70,
            ),
            const SizedBox(height: 20),

            //Check your email Text
            Center(
              child: Text(
                'Check your email to update your password',
                style: const TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 10, 15, 66),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),

            //Another email text
            Center(
              child: Text(
                'We sent a link to ${emailController.text} to update your password.',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 10, 15, 66),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            //Change Email gesture that takes us back to login screen
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: const Text(
                'Change Email',
                style: TextStyle(
                    color: Color.fromARGB(255, 30, 117, 188),
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),

            //Open email app button

            //Resend verification email gesture
            Container(
              child: GestureDetector(
                onTap: () {
                  //Resend email API implementation
                },
                child: const Text(
                  'Resend verification email',
                  style: TextStyle(
                      color: Color.fromARGB(255, 30, 117, 188),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              padding: EdgeInsets.only(top: 300),
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }
}
