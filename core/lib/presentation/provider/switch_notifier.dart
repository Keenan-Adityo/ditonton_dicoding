import 'package:flutter/material.dart';

class SwitchNotifier extends ChangeNotifier {
  String _data = 'movie';
  String get data => _data;

  void changeTV() {
    _data = 'tv';
    notifyListeners();
  }

  void changeMovie() {
    _data = 'movie';
    notifyListeners();
  }
}
