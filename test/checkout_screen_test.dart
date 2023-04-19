import 'package:envie_cross_platform/screens/check_out_screen.dart';
import 'package:flutter_test/flutter_test.dart';

///Unit tests for the checkout screen
void main() {
  group('Email validator', () {
    test('Empty email returns error message', () {
      final result = CheckOutScreen().emailValidator('');
      expect(result, 'Please enter an email');
    });

    test('Invalid email returns error message', () {
      final result = CheckOutScreen().emailValidator('invalidemail');
      expect(result, 'Please enter a valid email');
    });

    test('Valid email returns null', () {
      final result = CheckOutScreen().emailValidator('test@example.com');
      expect(result, null);
    });

    test('Should return error message when first name is empty', () {
      expect(CheckOutScreen().validateFirstName(''),
          'Please enter your first name');
    });

    test(
        'Should return error message when first name contains non-letter characters',
        () {
      expect(CheckOutScreen().validateFirstName('Nourhan123'),
          'Should only contain letters');
    });

    test('Should return error message when first name is too short', () {
      expect(CheckOutScreen().validateFirstName('N'),
          'Should be between 2 and 20 characters');
    });

    test('Should return error message when first name is too long', () {
      expect(
          CheckOutScreen()
              .validateFirstName('Nourhaaaaaaaaaaaaaaaaaaaaaaaaaaannnn'),
          'Should be between 2 and 20 characters');
    });

    test('Should return null when first name is valid', () {
      expect(CheckOutScreen().validateFirstName('Nourhan'), null);
    });

    // Sur Name validation function tests
    test('Should return error message when surname is empty', () {
      expect(CheckOutScreen().validateSurName(''), 'Please enter your surname');
    });

    test(
        'Should return error message when surname contains non-letter characters',
        () {
      expect(CheckOutScreen().validateSurName('Ahmed123'),
          'Should only contain letters');
    });

    test('Should return error message when surname is too short', () {
      expect(CheckOutScreen().validateSurName('A'),
          'Should be between 2 and 20 characters');
    });

    test('Should return error message when surname is too long', () {
      expect(CheckOutScreen().validateSurName('Ahmeddddddddddddddddd'),
          'Should be between 2 and 20 characters');
    });

    test('Should return null when surname is valid', () {
      expect(CheckOutScreen().validateSurName('Ahmed'), null);
    });
  });
}
