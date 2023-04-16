import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/event.dart';

// ChangeNotifier enables inherited widgets to establish commmunication channels behind the scenes
class CategoriesProvider with ChangeNotifier {
  List<Category> _allCategories = [];
  // String? _selectedCategoryID;

  set allCategories(List<Category> categories) {
    _allCategories = categories;
    notifyListeners();
  }

  List<Category> get allCategories {
    return [..._allCategories];
  }

  void updateCategorySelection(int index, bool isSelect) {
    _allCategories[index].isSelected = isSelect;
    notifyListeners();
  }

  String? get selectedCategoryID {
    String? categoryID;
    for (var category in _allCategories) {
      if (category.isSelected == true) {
        categoryID = category.id;
      }
    }
    //print("Category is: $categoryID");
    return categoryID;
  }

  void setAllFilters(List<bool> selectedCategories) {
    for (int i = 0; i < _allCategories.length; i++) {
      _allCategories[i].isSelected = selectedCategories[i];
    }
    notifyListeners();
  }

  // String? get selectedCategoryID {
  //   return _selectedCategoryID;
  // }

  // set selectedCategoryID(String? categoryID) {
  //   _selectedCategoryID = categoryID;
  //   notifyListeners();
  // }
}
