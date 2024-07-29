import 'dart:async';
import 'package:Easy/Model/PrivateChatModel.dart';
import 'package:Easy/common/SocketConnection/SocketClient.dart';
import 'package:Easy/provider/controller/ChatController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../Model/Hive/HivePrivateChatModel.dart';
import 'package:rxdart/rxdart.dart';

import '../../provider/controller/RepositoryController.dart';

class SocketMethods extends GetxController {
  final _socketClient = Get.put(SocketClient.instance.socket!);
  final ChatController chatController = Get.put(ChatController());
  final RepositoryController repositoryController =
      Get.put(RepositoryController());

  //final _messageController = StreamController<List<dynamic>>.broadcast();
  final _messageController = BehaviorSubject<List<dynamic>>();
  List<HivePrivateChatModel> temp = [];

  Stream<List<dynamic>> get messageStream => _messageController.stream;

  BehaviorSubject<List<dynamic>> get messageController => _messageController;

  Socket get socketClient => _socketClient;

  // EMITS
  void sendPrivateMessage(PrivateChatModel message) {
    _socketClient.emit('sendPrivateMessage', message.toJson());
  }

  void getAllOneToOneChatMessageGivenUser(String sender, String receiver) {
    final data = {
      'sender': sender,
      'receiver': receiver,
    };
    _socketClient.emit('get-all-one-to-one-chat-given-user', data);
  }

  // LISTENER
  void sendPrivateMessageSuccess() {
    _socketClient.on('sendPrivateMessageSuccess', (message) {
      void addMessage(dynamic message, String roomId) {
        List<dynamic> roomId = [];
        roomId.clear();
        roomId = _messageController.value ?? [];
        roomId.add(message);
        _messageController.sink.add(roomId);
      }

      DateFormat inputFormat = DateFormat('EEE MMM dd yyyy HH:mm:ss');
      DateFormat outputDateFormat = DateFormat.yMd(); // e.g. 1/1/2022
      DateFormat outputTimeFormat = DateFormat.jm(); // e.g. 5:08 PM

      String timeStampString = message['timeStamp'];
      String cleanedTimeStampString = timeStampString.split(' GMT')[0];

      DateTime timeStamp = inputFormat.parse(cleanedTimeStampString);
      String formattedDate = outputDateFormat.format(timeStamp);
      String formattedTime = outputTimeFormat.format(timeStamp);

      final messageData = HivePrivateChatModel(
        messageId: message['messageId'],
        message: message['message'],
        sender: message['sender'],
        receiver: message['receiver'],
        timeStamp: formattedTime,
        // Use the formatted time for each message
        isSeen: message['isSeen'],
      );
      //chatController.updatePrivateChatMessage(messageData);
      String roomId = repositoryController.generateRoomId(
          message['sender'], message['receiver']);
      addMessage(messageData, roomId);
    });
  }

  getAllOneToOneChatGivenUserListener() {
    _socketClient.on('get-all-one-to-one-chat-given-user-listener', (data) {
      DateFormat inputFormat = DateFormat('EEE MMM dd yyyy HH:mm:ss');
      DateFormat outputDateFormat = DateFormat.yMd(); // e.g. 1/1/2022
      DateFormat outputTimeFormat = DateFormat.jm(); // e.g. 5:08 PM

      // save in to local database
      List<dynamic> chatHistory = data.map((message) {
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

      // this for change list of dynamic to list of HiveModel to insert chat history
      List<HivePrivateChatModel> tempVar = [];
      for (int i = 0; i < chatHistory.length; i++) {
        HivePrivateChatModel temp = HivePrivateChatModel(
          messageId: chatHistory[i].messageId,
          message: chatHistory[i].message,
          sender: chatHistory[i].sender,
          receiver: chatHistory[i].receiver,
          timeStamp: chatHistory[i].timeStamp,
          isSeen: chatHistory[i].isSeen,
        );
        tempVar.add(temp);
      }

     // save in local database
      chatController.saveChatHistory(tempVar, data[0]['sender'], data[0]['receiver']);

      _messageController.add(chatHistory);

      update();
    });
  }

  void errorReceiver(BuildContext context) {
    //LowerSnackBar lowerSnackBar = Get.find();
    _socketClient.on('errorReceiver', (data) {
      //lowerSnackBar.failureSnackBar(context, data);
      print('--------- $data ----------');
      _messageController.add(temp);
    });
  }

  @override
  void dispose() {
    _messageController.close();
    super.dispose();
  }
}
