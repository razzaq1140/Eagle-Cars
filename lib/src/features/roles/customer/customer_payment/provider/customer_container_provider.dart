import 'package:flutter/material.dart';

class CustomerContainerProvider with ChangeNotifier {
  int _containerIndex = 0;
  int get containerIndex => _containerIndex;

  void selectCard(int index) {
    _containerIndex = index;
    notifyListeners();
  }
}
