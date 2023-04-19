import 'package:envie_cross_platform/models/category.dart';
import 'package:envie_cross_platform/providers/categories_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Category category1 = Category(
    id: '1',
    name: 'Music',
    isSelected: false,
  );
  Category category2 = Category(
    id: '2',
    name: 'Food & Drink',
    isSelected: false,
  );
  Category category3 = Category(
    id: '3',
    name: 'Charity & Causes',
    isSelected: false,
  );
  List<Category> categories = [category1, category2, category3];

  group('updateCategorySelection', () {
    test('selects the category at the given index', () {
      final model = CategoriesProvider();
      model.allCategories = categories;
      model.updateCategorySelection(0, true);
      expect(model.allCategories[0].isSelected, true);
    });

    test('deselects the category at the given index', () {
      final model = CategoriesProvider();
      model.allCategories = categories;
      model.updateCategorySelection(0, false);
      expect(model.allCategories[0].isSelected, false);
    });

    test('selects the category at the given index', () {
      final model = CategoriesProvider();
      model.allCategories = categories;
      model.updateCategorySelection(1, true);
      expect(model.allCategories[1].isSelected, true);
    });

    test('deselects the category at the given index', () {
      final model = CategoriesProvider();
      model.allCategories = categories;
      model.updateCategorySelection(1, false);
      expect(model.allCategories[1].isSelected, false);
    });
  });
}
