import 'package:envie_cross_platform/screens/creator_publish.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Password Validator', () {
    final validator = CreatorPublishState();
    test('Returns null when a valid password is provided', () {
      final result = validator.passwordValidator('passw0rd');

      expect(result, isNull);
    });

    test('Returns error message when the password is empty', () {
      final result = validator.passwordValidator('');

      expect(result, 'Please enter a valid password.');
    });

    test('Returns error message when the password is less than 8 characters', () {
      final result = validator.passwordValidator('1234');

      expect(result, 'Password must be at least 8 characters long');
    });
  });
}