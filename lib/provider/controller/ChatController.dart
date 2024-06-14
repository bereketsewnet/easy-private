import 'package:get/get.dart';

import '../../Model/PrivateChatModel.dart';

class ChatController extends GetxController {
  List<PrivateChatModel> _chatMessages = [];

  List<PrivateChatModel> get chatMessage => _chatMessages;

  void updatePrivateChatMessage(PrivateChatModel chatMessage) async {
    _chatMessages.add(chatMessage);
    update();
  }
}
