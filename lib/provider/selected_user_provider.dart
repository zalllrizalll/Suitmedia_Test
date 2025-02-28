import 'package:flutter/material.dart';

class SelectedUserProvider extends ChangeNotifier {
  String? _selectedUserName;

  String? get selectedUserName => _selectedUserName;

  void setSelectedUserName(String name) {
    _selectedUserName = name;
    notifyListeners();
  }
}
