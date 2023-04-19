import 'package:flutter_test/flutter_test.dart';
import '../lib/models/category.dart';
import '../lib/providers/categories_provider.dart';

void main() {
  group('setSelectedTimeCategory', () {
    test('sets the selected time category to week', () {
      final model = CategoriesProvider();
      model.selectedTimeCategory = 'This Week';
      expect(model.selectedTimeCategory, 'week');
    });
    test('sets the selected time category to month', () {
      final model = CategoriesProvider();
      model.selectedTimeCategory = 'This Month';
      expect(model.selectedTimeCategory, 'month');
    });
    test('sets the selected time category to tomorrow', () {
      final model = CategoriesProvider();
      model.selectedTimeCategory = 'Tomorrow';
      expect(model.selectedTimeCategory, 'tomorrow');
    });
    test('sets the selected time category to today', () {
      final model = CategoriesProvider();
      model.selectedTimeCategory = 'Today';
      expect(model.selectedTimeCategory, 'today');
    });

    test('sets the selected time category to null', () {
      final model = CategoriesProvider();
      model.selectedTimeCategory = null;
      expect(model.selectedTimeCategory, null);
    });
  });
}
