///This screen is the signup screen. It contains a form that the user can use to sign up to the app.
///It contains an email validation function to check that the text field is not empty and the email is in the right format.
///It validates the email and confirm email text fields to check that they match.
///It contains a password validation function to check that the text field is not empty and the password is at least 8 characters long.
///It contains a first name and surname validation function to check that the text fields are not empty and that they only contain letters.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';
import 'login_screen.dart';
import 'tabs_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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

  //Confirm Email validation function (to check that it's not empty and matches the other email)
  String? validateConfirmEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your email';
    }
    if (value != emailController.text) {
      return 'Emails do not match';
    }
    return null;
  }

  //First Name validation function (to check that the name is not empty and between 2 and 20 characters
  //and doesn't contain any characters other than letters)
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

  //Sur Name validation function (to check that the name is not empty and between 2 and 20 characters
  //and doesn't contain any characters other than letters)
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

  //Password validation function (to check that password field is not empty and has atleast 8 chatracters)
  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (context) => userProvider,
      child: Scaffold(
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
                    controller: emailController,
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
                      validator: validateConfirmEmail),
                  SizedBox(height: 10),

                  //Row containing First Name and Surname text fields
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: 'First name *',
                            ),
                            validator: validateFirstName),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                            controller: _surNameController,
                            decoration: InputDecoration(
                              labelText: 'Surname *',
                            ),
                            validator: validateSurName),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  //Password text field
                  TextFormField(
                    controller: _passwordController,
                    validator: validatePassword,
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        userProvider.signup(User(
                            firstName: _firstNameController.text,
                            surName: _surNameController.text,
                            email: emailController.text,
                            password: _passwordController.text));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'A verification email has been sent to your email address. Please click on the link to verify your account and login.'),
                            duration: Duration(seconds: 5),
                          ),
                        );

                        // Wait for 5 seconds before navigating to the TabsScreen route
                        // when we integrate with backend we don't navigate to TabsScreen unless email link is pressed and verified
                        Future.delayed(Duration(seconds: 5), () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        });
                      }
                    },
                    child: Text('SIGN UP'),
                  ),

                  SizedBox(height: 10),

                  //Already have an account? Login! Gesture
                  //Loads us to login screen
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName),
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
      ),
    );
  }
}
