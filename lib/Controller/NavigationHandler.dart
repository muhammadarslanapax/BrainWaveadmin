import 'package:flutter/material.dart';

class NavigationHandler extends ChangeNotifier {
  int? _selectedIndex;
  int get selectedIndex => _selectedIndex ?? 0;

  updateIndex({int index = 0}) {
    _selectedIndex = index;
    notifyListeners();
  }
}
