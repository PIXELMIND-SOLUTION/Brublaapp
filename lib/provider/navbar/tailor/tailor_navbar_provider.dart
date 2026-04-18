// lib/providers/navbar/tailor_navbar_provider.dart

import 'package:flutter/material.dart';

class TailorNavbarProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}