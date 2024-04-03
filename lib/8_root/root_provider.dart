import 'package:flutter/material.dart';

class RootProvider extends ChangeNotifier {
  int rootIndex = 0;
  void updateRootIndex(int newVal) {
    rootIndex = newVal;
    notifyListeners();
  }
}
