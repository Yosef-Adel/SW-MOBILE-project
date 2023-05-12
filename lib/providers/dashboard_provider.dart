/// This file contains the UserProvider class which is used to store the user data and the methods to update the user data.
import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  int _maxPages = 1;

  set maxPages(int value) {
    _maxPages = value;
    notifyListeners();
  }

  int get maxPages {
    return _maxPages;
  }
}
