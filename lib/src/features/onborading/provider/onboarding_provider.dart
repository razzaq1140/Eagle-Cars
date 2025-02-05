import 'package:flutter/foundation.dart';

class PageIndexProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setPageIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
