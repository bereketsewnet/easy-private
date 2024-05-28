import 'package:flutter/material.dart';
import 'package:Easy/CustomUi/CustomCard.dart';
import 'package:Easy/Screens/SelectContact.dart';

import '../Model/ChatModel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      name: 'Berket Sewnet',
      icon: 'person',
      isGroup: false,
      time: '10:12',
      currentMessage: 'Hi Bereket',
    ),
    ChatModel(
      name: 'Bati Sewnet',
      icon: 'person',
      isGroup: false,
      time: '20:02',
      currentMessage: 'Haha you are so funny',
    ),
    ChatModel(
      name: 'Code night',
      icon: 'group',
      isGroup: true,
      time: '10:12',
      currentMessage: 'hey guys!!',
    ),
    ChatModel(
      name: 'Amaru Mekuriay',
      icon: 'person',
      isGroup: false,
      time: '7:34',
      currentMessage: 'Let him cook',
    ),
    ChatModel(
      name: 'Wase Records',
      icon: 'group',
      isGroup: true,
      time: '02:44',
      currentMessage: 'new film coming soon',
    ),
    ChatModel(
      name: 'Azmeraw Mekuriay',
      icon: 'person',
      isGroup: false,
      time: '7:34',
      currentMessage: 'Let him cook',
    ),
    ChatModel(
      name: 'Samri Azmeraw',
      icon: 'person',
      isGroup: false,
      time: '7:34',
      currentMessage: 'Let him cook',
    ),
    ChatModel(
      name: 'Selam Wale',
      icon: 'person',
      isGroup: false,
      time: '7:34',
      currentMessage: 'Let him cook',
    ),
    ChatModel(
      name: 'Poe',
      icon: 'group',
      isGroup: true,
      time: '01:04',
      currentMessage: 'ask anything you want',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return CustomCard(
            chatModel: chats[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectContact(),
            ),
          );
        },
      ),
    );
  }
}
