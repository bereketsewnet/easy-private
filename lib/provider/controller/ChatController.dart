import 'dart:convert';

import 'package:Easy/Model/ErrorMessage.dart';
import 'package:Easy/common/SnackBar/lower_snack_bar.dart';
import 'package:Easy/common/constants/ConstantValue.dart';
import 'package:Easy/provider/controller/RepositoryController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../Model/Hive/HivePrivateChatModel.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  RepositoryController repositoryController = Get.put(RepositoryController());

  void updatePrivateChatMessage(HivePrivateChatModel chatMessage) async {
    addSingleMessage(chatMessage, chatMessage.sender, chatMessage.receiver);
    update();
  }


  Future<Box> openBox() async {
    return await Hive.openBox('privateChatBox');
  }

  Future<void> saveChatHistory(List<HivePrivateChatModel> chatHistory, String sender, String receiver) async {
    final box = await openBox();
    String roomId = repositoryController.generateRoomId(sender, receiver);
    await box.put(roomId, chatHistory);
  }


  Future<List<dynamic>?> getChatHistory(String sender, String receiver) async {
    final box = await openBox();
    String roomId = repositoryController.generateRoomId(sender, receiver);
    //box.delete(roomId);
    return box.get(roomId, defaultValue: null);
  }

  Future<void> addSingleMessage(HivePrivateChatModel newMessage, String sender, String receiver) async {
    final box = await openBox();
    String roomId = repositoryController.generateRoomId(sender, receiver);

    // Retrieve the current chat history
    List<dynamic>? chatHistory = box.get(roomId, defaultValue: null);

    if(chatHistory != null) {
      // Add the new message to the chat history
      chatHistory.add(newMessage);
    }

    // Save the updated chat history back to Hive
    await box.put(roomId, chatHistory);
  }
}
