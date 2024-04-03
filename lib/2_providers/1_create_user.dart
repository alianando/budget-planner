// ignore_for_file: file_names

import 'package:budget_planner/1_constants/2_helper.dart';
import 'package:flutter/material.dart';

class CreateUserProvider extends ChangeNotifier {
  List<String> existingUserName = [];
  String userName = '';
  String? userNameErrorTxt;
  String email = '';
  String? emailErrorTxt;
  String password = '';
  String? passwordError;
  bool showPassword = true;
  String photoUrl = '';
  String buttonTxt = 'Add';

  void updateExistingUserName(List<String> newVal) {
    existingUserName = newVal;
  }

  void updateName(String? value) {
    userNameErrorTxt = null;
    if (value != null) {
      userName = value;
    }
    if (value == null || value.isEmpty) {
      userNameErrorTxt = 'User name can not be null';
    }
    if (existingUserName.contains(value)) {
      userNameErrorTxt = 'Can not use this user name';
    }
    notifyListeners();
  }

  void updateEmail(String? value) {
    emailErrorTxt = null;
    if (value != null) {
      email = value;
    }
    if (value == null || value.isEmpty) {
      emailErrorTxt = 'Email can not be null';
    } else if (value.contains(' ')) {
      emailErrorTxt = 'Not valid email';
    } else if (!value.contains('@')) {
      emailErrorTxt = 'Not valid email';
    } else if (!value.contains('.com')) {
      emailErrorTxt = 'Not valid email';
    }
    notifyListeners();
  }

  void updatePassword(String? value) {
    passwordError = null;
    if (value != null) {
      password = value;
    }
    passwordError = validatePasswordString(value);
    notifyListeners();
  }

  void updateShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void addProfileUrl(String newVal) {
    photoUrl = newVal;
    notifyListeners();
  }

  void updateButtonTxt(String newVal) {
    buttonTxt = newVal;
    notifyListeners();
  }

  void removeAll() {
    notifyListeners();
  }
}
