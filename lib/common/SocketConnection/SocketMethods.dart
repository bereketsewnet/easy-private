import 'dart:convert';

import 'package:Easy/Model/PrivateChatModel.dart';
import 'package:Easy/common/SocketConnection/SocketClient.dart';
import 'package:Easy/provider/controller/ChatController.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
      final messageData = PrivateChatModel.fromJson(message);
      chatController.updatePrivateChatMessage(messageData);
    });
  }
}
