import 'package:Easy/common/SocketConnection/SocketClient.dart';
import 'package:Easy/provider/controller/ChatController.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods extends GetxController {

  final _socketClient = Get.put(SocketClient.instance.socket!);
  final ChatController chatController = Get.put(ChatController());

  Socket get socketClient => _socketClient;

  // EMITS
  void sendPrivateMessage() {
    _socketClient.emit('sendPrivateMessage', {
      'user': 'hey',
    });
  }

  // LISTENER

  void personalChatCreateSuccess() {
    _socketClient.on('success', (data) => {print(data)});
  }
}
