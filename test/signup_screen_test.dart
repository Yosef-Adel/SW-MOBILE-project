import 'package:flutter_test/flutter_test.dart';
import 'package:envie_cross_platform/screens/signup_screen.dart';

void main() {
  group('Signup Screen Validation Functions Tests', () {
    late SignupScreen signupScreen;
    late SignupScreenState signupScreenState;

    setUp(() {
      signupScreen = SignupScreen();
      signupScreenState = signupScreen.createState() as SignupScreenState;
    });

    // Email validation function tests
    test('Should return error message when email is empty', () {
      expect(signupScreenState.emailValidator(''), 'Please enter an email');
    });

    test('Should return error message when email is invalid', () {
      expect(signupScreenState.emailValidator('invalidemail'),
          'Please enter a valid email');
    });

    test('Should return null when email is valid', () {
      expect(signupScreenState.emailValidator('test@example.com'), null);
    });

    // Confirm Email validation function tests
    test('Should return error message when confirm email is empty', () {
      signupScreenState.emailController.text = 'test@example.com';
      expect(signupScreenState.validateConfirmEmail(''),
          'Please confirm your email');
    });

    test('Should return error message when confirm email does not match email',
        () {
      signupScreenState.emailController.text = 'test@example.com';
      expect(signupScreenState.validateConfirmEmail('test2@example.com'),
          'Emails do not match');
    });

    test('Should return null when confirm email matches email', () {
      signupScreenState.emailController.text = 'test@example.com';
      expect(signupScreenState.validateConfirmEmail('test@example.com'), null);
    });

    // First Name validation function tests
    test('Should return error message when first name is empty', () {
      expect(signupScreenState.validateFirstName(''),
          'Please enter your first name');
    });

    test(
        'Should return error message when first name contains non-letter characters',
        () {
      expect(signupScreenState.validateFirstName('Nourhan123'),
          'Should only contain letters');
    });

    test('Should return error message when first name is too short', () {
      expect(signupScreenState.validateFirstName('N'),
          'Should be between 2 and 20 characters');
    });

    test('Should return error message when first name is too long', () {
      expect(
          signupScreenState
              .validateFirstName('Nourhaaaaaaaaaaaaaaaaaaaaaaaaaaannnn'),
          'Should be between 2 and 20 characters');
    });

    test('Should return null when first name is valid', () {
      expect(signupScreenState.validateFirstName('Nourhan'), null);
    });

    // Sur Name validation function tests
    test('Should return error message when surname is empty', () {
      expect(
          signupScreenState.validateSurName(''), 'Please enter your surname');
    });

    test(
        'Should return error message when surname contains non-letter characters',
        () {
      expect(signupScreenState.validateSurName('Ahmed123'),
          'Should only contain letters');
    });

    test('Should return error message when surname is too short', () {
      expect(signupScreenState.validateSurName('A'),
          'Should be between 2 and 20 characters');
    });

    test('Should return error message when surname is too long', () {
      expect(signupScreenState.validateSurName('Ahmeddddddddddddddddd'),
          'Should be between 2 and 20 characters');
    });

    test('Should return null when surname is valid', () {
      expect(signupScreenState.validateSurName('Ahmed'), null);
    });

    // Password validation function tests
    test('Should return error message when password is empty', () {
      expect(signupScreenState.validatePassword(''), 'Please enter a password');
    });

    test('Should return error message when password is too short', () {
      expect(signupScreenState.validatePassword('1234567'),
          'Password must be at least 8 characters long');
    });

    test('Should return null when password is valid', () {
      expect(signupScreenState.validatePassword('12345678'), null);
    });
  });
}
