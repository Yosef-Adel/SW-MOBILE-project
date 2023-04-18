import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/event.dart';

// ChangeNotifier enables inherited widgets to establish commmunication channels behind the scenes
class CategoriesProvider with ChangeNotifier {
  List<Category> _allCategories = [];
  String? _selectedTimeCategory;
  bool _isOnlineCategory = false;
  String? locationDropDownValue = 'In my current Location';

  set isOnlineCategory(bool isOnline) {
    _isOnlineCategory = isOnline;
    notifyListeners();
  }

  bool get isOnlineCategory {
    return _isOnlineCategory;
  }

  set selectedTimeCategory(String? timeCategory) {
    if (timeCategory != null && timeCategory == 'This Week')
      _selectedTimeCategory = 'week';
    else if (timeCategory != null && timeCategory == 'This Month')
      _selectedTimeCategory = 'month';
    else if (timeCategory != null && timeCategory == 'Today')
      _selectedTimeCategory = timeCategory.toLowerCase();
    else if (timeCategory != null && timeCategory == 'Tomorrow')
      _selectedTimeCategory = timeCategory.toLowerCase();
    else
      _selectedTimeCategory = null;
    notifyListeners();
  }

  String? get selectedTimeCategory {
    return _selectedTimeCategory;
  }

  bool get isTimeCategorySelected {
    return _selectedTimeCategory != null;
  }

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

  String? get selectedCategoryName {
    String? categoryName;
    for (var category in _allCategories) {
      if (category.isSelected == true) {
        categoryName = category.name;
      }
    }
    return categoryName;
  }

  bool get isCategorySelected {
    bool isCategorySelected = false;
    for (var category in _allCategories) {
      if (category.isSelected == true) {
        isCategorySelected = true;
      }
    }
    return isCategorySelected;
  }

  void setAllFilters(List<bool> selectedCategories) {
    for (int i = 0; i < _allCategories.length; i++) {
      _allCategories[i].isSelected = selectedCategories[i];
    }
    notifyListeners();
  }

  void clearFilters() {
    for (int i = 0; i < _allCategories.length; i++) {
      _allCategories[i].isSelected = false;
    }
    notifyListeners();
  }

  // set selectedCategoryID(String? categoryID) {
  //   _selectedCategoryID = categoryID;
  //   notifyListeners();
  // }
}
