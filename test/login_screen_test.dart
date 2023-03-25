import 'package:flutter_test/flutter_test.dart';
import 'package:envie_cross_platform/screens/login_screen.dart';

///Unit tests for the login screen
void main() {
  group('Email validator', () {
    test('Empty email returns error message', () {
      final result = LoginScreen().emailValidator('');
      expect(result, 'Please enter an email');
    });

    test('Invalid email returns error message', () {
      final result = LoginScreen().emailValidator('invalidemail');
      expect(result, 'Please enter a valid email');
    });

    test('Valid email returns null', () {
      final result = LoginScreen().emailValidator('test@example.com');
      expect(result, null);
    });
  });
}
