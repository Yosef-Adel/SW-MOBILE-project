import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  // Email validation function (to check that it's not empty and in the right format)
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

  // Confirm Email validation function (to check that it's not empty and matches the other email)
  String? validateConfirmEmail(String? value, String? email) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your email';
    }
    if (value != email) {
      return 'Emails do not match';
    }
    return null;
  }

  // First Name validation function (to check that the name is not empty and between 2 and 20 characters
  // and doesn't contain any characters other than letters)
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

  // Sur Name validation function (to check that the name is not empty and between 2 and 20 characters
  // and doesn't contain any characters other than letters)
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

  // Password validation function (to check that password field is not empty and has atleast 8 chatracters)
  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
}
