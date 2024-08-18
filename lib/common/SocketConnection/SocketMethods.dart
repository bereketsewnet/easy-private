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

  Future<void> getAllOneToOneChatMessageGivenUser(
      String sender, String receiver) async {
    int messageOrder =
        await chatController.getMessageOrder(sender, receiver) ?? 0;
    final data = {
      'sender': sender,
      'receiver': receiver,
      'messageOrder': messageOrder,
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
    _socketClient.on('get-all-one-to-one-chat-given-user-listener',
        (data) async {
      DateFormat inputFormat = DateFormat('EEE MMM dd yyyy HH:mm:ss');
      DateFormat outputDateFormat = DateFormat.yMd(); // e.g. 1/1/2022
      DateFormat outputTimeFormat = DateFormat.jm(); // e.g. 5:08 PM

      // save in to local database
      List<dynamic> latestMessage = data.map((message) {
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
      for (int i = 0; i < latestMessage.length; i++) {
        HivePrivateChatModel temp = HivePrivateChatModel(
          messageId: latestMessage[i].messageId,
          message: latestMessage[i].message,
          sender: latestMessage[i].sender,
          receiver: latestMessage[i].receiver,
          timeStamp: latestMessage[i].timeStamp,
          isSeen: latestMessage[i].isSeen,
        );
        tempVar.add(temp);
      }

      // save in local database
      await chatController.saveChatHistory(
          tempVar, data[0]['sender'], data[0]['receiver']);
      // save in to shared prefs messageOrder
      await chatController.saveMessageOrder(
        data[0]['sender'],
        data[0]['receiver'],
        data[data.length - 1]['messageOrder'],
      );

      final chatHistory = await chatController.getChatHistory(
        data[0]['sender'],
        data[0]['receiver'],
      );
      if (chatHistory != null && chatHistory.isNotEmpty) {
        _messageController.add(chatHistory);
      } else {
        _messageController.add(latestMessage);
      }

      update();
    });
  }

  void errorReceiver(BuildContext context) {
    _socketClient.on('errorReceiver', (data) async {
      if (data != 'No messages found') {
        _messageController.add(temp);
      }
    });
  }

  @override
  void dispose() {
    _messageController.close();
    super.dispose();
  }
}
