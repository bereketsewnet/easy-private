import 'package:Easy/provider/controller/RepositoryController.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../Model/Hive/HivePrivateChatModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  RepositoryController repositoryController = Get.put(RepositoryController());

  void updatePrivateChatMessage(HivePrivateChatModel chatMessage) async {
    addSingleMessage(chatMessage, chatMessage.sender, chatMessage.receiver);
    update();
  }


  Future<Box> openBox() async {
    //await box.deleteFromDisk();
    return await Hive.openBox('LocalUserDatabase');
  }

  Future<void> saveChatHistory(List<HivePrivateChatModel> chatHistory, String sender, String receiver) async {
    final box = await openBox();
    String roomId = repositoryController.generateRoomId(sender, receiver);
    List<HivePrivateChatModel> existingChatHistory = await box.get(roomId) ?? [];
    List<HivePrivateChatModel> collectionChat = [...existingChatHistory, ...chatHistory];
    await box.put(roomId, collectionChat);
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

  Future<void> saveMessageOrder(String sender, String receiver, int messageOrder) async{
    String roomId = repositoryController.generateRoomId(sender, receiver);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(roomId, messageOrder);

  }

  Future<int?> getMessageOrder(String sender, String receiver) async{
    String roomId = repositoryController.generateRoomId(sender, receiver);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove(roomId);
    return prefs.getInt(roomId);
  }
}
