// import 'package:flutter/material.dart';

// class BottomNavbarProvider extends ChangeNotifier {
//   int _currentIndex = 0;

//   int get currentIndex => _currentIndex;

//   void setIndex(int index) {
//     _currentIndex = index;
//     notifyListeners();
//   }
// }











// lib/providers/navbar/user_navbar_provider.dart

import 'package:flutter/material.dart';

class UserNavbarProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}