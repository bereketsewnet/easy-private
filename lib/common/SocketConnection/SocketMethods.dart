import 'dart:convert';

import 'package:Easy/Model/PrivateChatModel.dart';
import 'package:Easy/common/SocketConnection/SocketClient.dart';
import 'package:Easy/provider/controller/ChatController.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../Model/Hive/HivePrivateChatModel.dart';

class SocketMethods extends GetxController {
  final _socketClient = Get.put(SocketClient.instance.socket!);
  final ChatController chatController = Get.put(ChatController());

  Socket get socketClient => _socketClient;

  // EMITS
  void sendPrivateMessage(PrivateChatModel message) {
    _socketClient.emit('sendPrivateMessage', message.toJson());
  }

  // LISTENER
  void sendPrivateMessageSuccess() {
    _socketClient.on('sendPrivateMessageSuccess', (message) {
      DateFormat inputFormat = DateFormat('EEE MMM dd yyyy HH:mm:ss');
      DateFormat outputDateFormat = DateFormat.yMd(); // e.g. 1/1/2022
      DateFormat outputTimeFormat = DateFormat.jm(); // e.g. 5:08 PM

      String timeStampString =
      message['timeStamp']; // Get the timestamp string for each message
      String cleanedTimeStampString =
      timeStampString.split(' GMT')[0]; // Remove the timezone part

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
       chatController.updatePrivateChatMessage(messageData);
    });
  }
}
