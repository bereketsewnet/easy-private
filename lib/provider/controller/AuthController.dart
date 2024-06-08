import 'dart:convert';

import 'package:Easy/Model/ErrorMessage.dart';
import 'package:Easy/Model/UserModel.dart';
import 'package:Easy/common/SnackBar/lower_snack_bar.dart';
import 'package:Easy/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/ConstantValue.dart';


class AuthController extends GetxController {
  LowerSnackBar lowerSnackBar = Get.find();

  Future<void> loginUser(BuildContext context, String email, String password) async {
    try {
      final url = Uri.parse(baseUrl+'users/login');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        final user =  User.fromJson(userData);
        lowerSnackBar.successSnackBar(context, 'Login Successfully!');
        Get.to(() => HomePage());
        return;
      } else if(response.statusCode == 400) {
        final errorMessage = jsonDecode(response.body);
        lowerSnackBar.failureSnackBar(context, ErrorMessage.fromJson(errorMessage).message);
        return;
      } else {

        throw Exception('Failed to login user');
      }
    }catch (e){
      lowerSnackBar.failureSnackBar(context, e.toString());
    }
  }
}