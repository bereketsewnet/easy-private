import 'dart:convert';

import 'package:Easy/Model/ErrorMessage.dart';
import 'package:Easy/common/SnackBar/lower_snack_bar.dart';
import 'package:Easy/common/SocketConnection/SocketMethods.dart';
import 'package:Easy/common/constants/ConstantValue.dart';
import 'package:Easy/provider/controller/RepositoryController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../Model/Hive/HivePrivateChatModel.dart';
import '../../Model/PrivateChatModel.dart';
import 'package:intl/intl.dart';

import 'UserController.dart';

class ChatController extends GetxController {
  RepositoryController repositoryController = Get.put(RepositoryController());

  void updatePrivateChatMessage(HivePrivateChatModel chatMessage) async {
    addSingleMessage(chatMessage, chatMessage.sender, chatMessage.receiver);
    update();
  }


  Future<List<dynamic>?> getAllPrivateChatMessage(
      BuildContext context, String sender, String receiver) async {

    RepositoryController repositoryController = Get.put(RepositoryController());
    LowerSnackBar lowerSnackBar = Get.find();

    String roomId = repositoryController.generateRoomId(sender, receiver);
    final url = Uri.parse('${baseUrl}chats/$roomId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      DateFormat inputFormat = DateFormat('EEE MMM dd yyyy HH:mm:ss');
      DateFormat outputDateFormat = DateFormat.yMd(); // e.g. 1/1/2022
      DateFormat outputTimeFormat = DateFormat.jm(); // e.g. 5:08 PM

      // save in to local database
      List<HivePrivateChatModel> chatHistory = jsonResponse.map((message) {
        String timeStampString =
            message['timeStamp']; // Get the timestamp string for each message
        String cleanedTimeStampString =
            timeStampString.split(' GMT')[0]; // Remove the timezone part

        DateTime timeStamp = inputFormat.parse(cleanedTimeStampString);
        String formattedDate = outputDateFormat.format(timeStamp);
        String formattedTime = outputTimeFormat.format(timeStamp);

        return HivePrivateChatModel(
          messageId: message['messageId'],
          message: message['message'],
          sender: message['sender'],
          receiver: message['receiver'],
          timeStamp: formattedTime,
          // Use the formatted time for each message
          isSeen: message['isSeen'],
        );
      }).toList();

     await saveChatHistory(chatHistory, sender, receiver);

      update();
      return chatHistory;
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
    return null;
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
    List<dynamic> chatHistory = box.get(roomId, defaultValue: null);

    // Add the new message to the chat history
    chatHistory.add(newMessage);

    // Save the updated chat history back to Hive
    await box.put(roomId, chatHistory);
  }
}
