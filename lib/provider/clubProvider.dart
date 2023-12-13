import 'package:flutter/material.dart';

class PickClub with ChangeNotifier {
  String _select = '';
  String get select => _select;

  String _selectClub = '';
  String get selectClub => _selectClub;

  int _selectIndex = 0;
  int get selectIndex => _selectIndex;

  void pickClub(String input) {
    _selectClub = input;

    notifyListeners();
  }

  void pickMy(String input) {
    _select = input;
    notifyListeners();
  }

  void pickIndex(int input) {
    _selectIndex = input;
    notifyListeners();
  }
}
