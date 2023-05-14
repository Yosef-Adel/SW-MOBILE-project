import 'package:envie_cross_platform/widgets/creator_promocode_form_popup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Date Range Validator', () {
    test('Returns null when both start and end dates are empty', () {
      final controller = PromocodeFormPopupState();
      // Set up test conditions
      controller.sellingStartDateController.text = '';
      controller.startDateController.text = '';
      controller.sellingEndDateController.text = '';
      controller.endDateController.text = '';

      final result = controller.dateRangeValidator();

      expect(result, isNull);
    });

    test('Returns null when start date is before end date', () {
      final controller = PromocodeFormPopupState();
      // Set up test conditions
      controller.sellingStartDateController.text = '2023-01-01';
      controller.startDateController.text = '2023-01-01';
      controller.sellingEndDateController.text = '2023-01-31';
      controller.endDateController.text = '2023-01-31';

      final result = controller.dateRangeValidator();

      expect(result, isNull);
    });

    test('Returns error message when start date is after end date', () {
      final controller = PromocodeFormPopupState();
      // Set up test conditions
      controller.sellingStartDateController.text = '2023-02-01';
      controller.startDateController.text = '2023-02-01';
      controller.sellingEndDateController.text = '2023-01-31';
      controller.endDateController.text = '2023-01-31';

      final result = controller.dateRangeValidator();

      expect(result, 'Start date must be before end date');
    });
  });
  group('Name Validator', () {
    final validator = PromocodeFormPopupState();
    test('Returns null when value is provided', () {
      
      final result = validator.nameValidator('Promo123');

      expect(result, isNull);
    });
    test('Returns error message when value and CSV are not provided', () {
      final result = validator.nameValidator('');

      expect(result, 'Please enter a promocode');
    });
  });
}
