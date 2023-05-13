import 'package:envie_cross_platform/screens/creator_add_basic_info_screen.dart';
import 'package:flutter_test/flutter_test.dart';

///Unit tests for the creator add basic info screen
void main() {
  group('Event basic info validator', () {
    test('No numbers allowed in city text', () {
      final result = EventBasicInfoState().countryValidator("123");
      expect(result, "please enter a letter");
    });

      test('No numbers allowed in city text', () {
      final result = EventBasicInfoState().countryValidator("Abc123");
      expect(result, "please enter a letter");
    });

      test('No input in country', () {
      final result = EventBasicInfoState().countryValidator("");
      expect(result, "please enter this field");
    });

      test('No text added check', () {
        final result = EventBasicInfoState().emptyValidator("");
        expect(result, 'please enter this field');
      });

      test('Valid country', () {
        final result = EventBasicInfoState().countryValidator("Massr");
        expect(result, null);
      });
      test('Valid city', () {
        final result = EventBasicInfoState().countryValidator("Giza");
        expect(result, null);
      });

   test('No numbers allowed in city text', () {
      final result = EventBasicInfoState().countryValidator("123abcccc");
      expect(result, "please enter a letter");
    });

      test(
          'valid title',
          () {
        expect(EventBasicInfoState().emptyValidator('Nourhan123'),
            null);
      });


      

    //   test('Should return error message when first name is too short', () {
    //     expect(CheckOutScreen().validateFirstName('N'),
    //         'Should be between 2 and 20 characters');
    //   });

    //   test('Should return error message when first name is too long', () {
    //     expect(
    //         CheckOutScreen()
    //             .validateFirstName('Nourhaaaaaaaaaaaaaaaaaaaaaaaaaaannnn'),
    //         'Should be between 2 and 20 characters');
    //   });

    //   test('Should return null when first name is valid', () {
    //     expect(CheckOutScreen().validateFirstName('Nourhan'), null);
    //   });

    //   // Sur Name validation function tests
    //   test('Should return error message when surname is empty', () {
    //     expect(CheckOutScreen().validateSurName(''), 'Please enter your surname');
    //   });

    //   test(
    //       'Should return error message when surname contains non-letter characters',
    //       () {
    //     expect(CheckOutScreen().validateSurName('Ahmed123'),
    //         'Should only contain letters');
    //   });

    //   test('Should return error message when surname is too short', () {
    //     expect(CheckOutScreen().validateSurName('A'),
    //         'Should be between 2 and 20 characters');
    //   });

    //   test('Should return error message when surname is too long', () {
    //     expect(CheckOutScreen().validateSurName('Ahmeddddddddddddddddd'),
    //         'Should be between 2 and 20 characters');
    //   });

    //   test('Should return null when surname is valid', () {
    //     expect(CheckOutScreen().validateSurName('Ahmed'), null);
    //   });
  });
}
