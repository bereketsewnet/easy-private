import 'dart:convert';
import 'dart:io';

import 'package:Easy/Model/ErrorMessage.dart';
import 'package:Easy/Model/UserModel.dart';
import 'package:Easy/common/SnackBar/lower_snack_bar.dart';
import 'package:Easy/pages/HomePage.dart';
import 'package:Easy/pages/auth%20pages/LoginPage.dart';
import 'package:Easy/provider/controller/UserController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/ConstantValue.dart';

class AuthController extends GetxController {
  LowerSnackBar lowerSnackBar = Get.find();
  UserController userController = Get.find();

  // login user
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      userController.controlLoading(true);
      final url = Uri.parse('${baseUrl}users/login');
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
        final user = User.fromJson(userData);
        userController.updateCurrentUser(user);
        userController.controlLoading(false);
        lowerSnackBar.helpSnackBar(context, 'We are happy to see you again! \n Welcome to Easy', userController.currentUser.firstName);
        Get.off(() => const HomePage());
        return;
      } else if (response.statusCode == 400) {
        final errorMessage = jsonDecode(response.body);
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(
            context, ErrorMessage.fromJson(errorMessage).message);
        return;
      } else {
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(context, 'Error When Login User!');
      }
    } catch (e) {
      userController.controlLoading(false);
      lowerSnackBar.failureSnackBar(context, e.toString());
    }
  }

  // register user with profile image
  Future<void> registerUserWithProfile(
    BuildContext context,
    File imageFile,
    String fName,
    String lName,
    String email,
    String password,
    String phoneNumber,
    String userType,
    String sex,
  ) async {
    try {
      userController.controlLoading(true);
      final url = Uri.parse('${baseUrl}users/registerwithprofile');
      final request = http.MultipartRequest('POST', url);
      request.fields['fName'] = fName;
      request.fields['lName'] = lName;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['userType'] = userType;
      request.fields['sex'] = sex;


      final uploadFile = http.MultipartFile(
          'image', imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
          filename: imageFile.path);

      request.files.add(uploadFile);
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 201) {
        final userInfo = jsonDecode(response.body);
        final user = User.fromJson(userInfo);
        userController.updateCurrentUser(user);
        userController.controlLoading(false);
        lowerSnackBar.successSnackBar(context, 'Register Successfully!');
        Get.offAll(() => const HomePage());
        return;
      } else if (response.statusCode == 400) {
        final errorMessage = jsonDecode(response.body);
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(
            context, ErrorMessage.fromJson(errorMessage).message);
        return;
      } else if (response.statusCode == 403) {
        final errorMessage = jsonDecode(response.body);
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(
            context, ErrorMessage.fromJson(errorMessage).message);
        return;
      } else if (response.statusCode == 500) {
        final errorMessage = jsonDecode(response.body);
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(
            context, ErrorMessage.fromJson(errorMessage).message);
        return;
      } else {
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(context, 'Unknown error');
      }
    } catch (e) {
      userController.controlLoading(false);
      lowerSnackBar.failureSnackBar(context, e.toString());
    }
  }

  // register user
  Future<void> registerUser(
    BuildContext context,
    String fName,
    String lName,
    String email,
    String password,
    String phoneNumber,
    String userType,
    String sex,
  ) async {
    try {
      userController.controlLoading(true);
      final url = Uri.parse('${baseUrl}users/register');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'fName': fName,
          'lName': lName,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
          'userType': userType,
          'sex': sex,
        }),
      );

      if (response.statusCode == 201) {
        final userInfo = jsonDecode(response.body);
        final user = User.fromJson(userInfo);
        userController.updateCurrentUser(user);
        userController.controlLoading(false);
        lowerSnackBar.successSnackBar(context, 'Register Successfully!');
        Get.offAll(() => const HomePage());
        return;
      } else if (response.statusCode == 400) {
        final errorMessage = jsonDecode(response.body);
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(
            context, ErrorMessage.fromJson(errorMessage).message);
        return;
      } else if (response.statusCode == 403) {
        final errorMessage = jsonDecode(response.body);
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(
            context, ErrorMessage.fromJson(errorMessage).message);
        return;
      } else if (response.statusCode == 500) {
        final errorMessage = jsonDecode(response.body);
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(
            context, ErrorMessage.fromJson(errorMessage).message);
        return;
      } else {
        userController.controlLoading(false);
        lowerSnackBar.failureSnackBar(context, 'Unknown error');
      }
    } catch (e) {
      userController.controlLoading(false);
      lowerSnackBar.failureSnackBar(context, e.toString());
    }
  }


  Future<void> logOut(BuildContext context) async {
    try {
      LowerSnackBar lowerSnackBar = Get.find();

      final url = Uri.parse(baseUrl + 'users/logout');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final message = jsonDecode(response.body);
        final messageInstance = ErrorMessage.fromJson(message);
        lowerSnackBar.successSnackBar(context, messageInstance.message);
        Get.off(const LoginPage());
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = ErrorMessage.fromJson(error);
        lowerSnackBar.failureSnackBar(context, errorMessage.message);
        return;
      }
    } catch (e) {
      lowerSnackBar.failureSnackBar(context, e.toString());
    }
  }

}
