import 'package:envie_cross_platform/screens/creator_add_basic_info_screen.dart';
import 'package:flutter_test/flutter_test.dart';

///Unit tests for the creator ticket pop up screen
void main() {
  group('Event basic info validator', () {
    test('No numbers allowed in city text', () {
      final result = EventBasicInfoState().countryValidator("123222");
      expect(result, "please enter a letter");
    });

      test('No numbers allowed in city text', () {
      final result = EventBasicInfoState().countryValidator("lll123");
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
        final result = EventBasicInfoState().countryValidator("Mars");
        expect(result, null);
      });
      test('Valid city', () {
        final result = EventBasicInfoState().countryValidator("startrek");
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
  });
}
