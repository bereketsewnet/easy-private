import 'dart:convert';

import 'package:Easy/Model/ErrorMessage.dart';
import 'package:Easy/common/SnackBar/lower_snack_bar.dart';
import 'package:Easy/common/constants/ConstantValue.dart';
import 'package:Easy/provider/controller/RepositoryController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Model/PrivateChatModel.dart';

class ChatController extends GetxController {
  List<PrivateChatModel> _chatMessages = [];

  List<PrivateChatModel> get chatMessage => _chatMessages;

  void updatePrivateChatMessage(PrivateChatModel chatMessage) async {
    _chatMessages.add(chatMessage);
    update();
  }

  Future<List<PrivateChatModel>> getAllPrivateChatMessage(
      BuildContext context, String sender, String receiver) async {
    RepositoryController repositoryController = Get.put(RepositoryController());
    LowerSnackBar lowerSnackBar = Get.find();

    String roomId = repositoryController.generateRoomId(sender, receiver);
    final url = Uri.parse('${baseUrl}chats/$roomId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      _chatMessages.clear();
      _chatMessages = jsonResponse
          .map((message) => PrivateChatModel.fromJson(message))
          .toList();
      update();
      return jsonResponse
          .map((message) => PrivateChatModel.fromJson(message))
          .toList();
    } else if (response.statusCode == 404) {
      final errorData = jsonDecode(response.body);
      final errorMessage = ErrorMessage.fromJson(errorData);
      lowerSnackBar.failureSnackBar(context, errorMessage.message);
    } else if (response.statusCode == 500) {
      final errorData = jsonDecode(response.body);
      final errorMessage = ErrorMessage.fromJson(errorData);
      lowerSnackBar.failureSnackBar(context, errorMessage.message);
    } else {
      lowerSnackBar.failureSnackBar(context, 'Unknown Error!');
    }
    return [];
  }
}
