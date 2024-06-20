import 'dart:convert';

import 'package:Easy/Model/ErrorMessage.dart';
import 'package:Easy/Model/UserModel.dart';
import 'package:Easy/common/SnackBar/lower_snack_bar.dart';
import 'package:Easy/common/constants/ConstantValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  User? _currentUser;
  bool _isLoading = false;
  List<User> _allUsersList = [];

  User? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

  List<User> get allUsersList => _allUsersList;

  void updateCurrentUser(User user) {
    _currentUser = user;
  }

  void controlLoading(bool loading) {
    _isLoading = loading;
    update();
  }

  Future<List<User>> getAllUsers(BuildContext context) async {
    LowerSnackBar lowerSnackBar = Get.find();
    UserController userController = Get.find();
    userController.controlLoading(true);
    try {
      final url = Uri.parse(baseUrl + 'users');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        userController.controlLoading(false);
        final List<dynamic> jsonData = jsonDecode(response.body);
        _allUsersList = jsonData.map((json) => User.fromJson(json)).toList();
        // Filter out the user with my ID
        _allUsersList = _allUsersList
            .where((user) => user.id != userController.currentUser!.id)
            .toList();
        update();
        userController.controlLoading(false);
        return _allUsersList = _allUsersList
            .where((user) => user.id != userController.currentUser!.id)
            .toList();
      } else {
        final errorJson = jsonDecode(response.body);
        final errorObject = ErrorMessage.fromJson(errorJson);
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(context, errorObject.message);
      }
    } catch (e) {
      userController.controlLoading(false);
      lowerSnackBar.failureSnackBar(context, e.toString());
    }
    return [];
  }
}
