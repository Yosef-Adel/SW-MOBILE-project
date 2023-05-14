/// This file contains the provider for the dashboard screen.
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
