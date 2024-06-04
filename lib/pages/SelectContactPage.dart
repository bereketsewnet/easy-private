import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Easy/pages/CreateGroupPage.dart';

import '../Model/ChatModel.dart';
import '../common/custom_widget/ButtomCard.dart';
import '../common/custom_widget/ContactCard.dart';

class SelectContactPage extends StatefulWidget {
  const SelectContactPage({super.key});

  @override
  State<SelectContactPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  List<ChatModel> chats = [
    ChatModel(
      name: 'Berket Sewnet',
      status: 'full stack developer',
    ),
    ChatModel(
      name: 'Bati Sewnet',
      status: 'mobile developer',
    ),
    ChatModel(name: 'Code night', status: 'nothing'),
    ChatModel(name: 'Amaru Mekuriay', status: 'web developer'),
    ChatModel(name: 'Wase Records', status: 'front end developer'),
    ChatModel(name: 'Azmeraw Mekuriay', status: 'presdant'),
    ChatModel(name: 'Samri Azmeraw', status: 'student'),
    ChatModel(name: 'Selam Wale', status: 'tik tok er'),
    ChatModel(name: 'Poe', status: 'ai generate'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Contact',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '256 contacts',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 26,
            ),
          ),
          PopupMenuButton(onSelected: (value) {
            if (kDebugMode) {
              print(value);
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'Invite a friend',
                child: Text('Invite a friend'),
              ),
              const PopupMenuItem(
                value: 'Contacts',
                child: Text('Contacts'),
              ),
              const PopupMenuItem(
                value: 'Refresh',
                child: Text('Refresh'),
              ),
              const PopupMenuItem(
                value: 'Help',
                child: Text('Help'),
              ),
            ];
          }),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateGroupPage(),
                  ),
                );
              },
              child: const ButtonCard(
                icon: Icons.group,
                name: 'New group',
              ),
            );
          } else if (index == 1) {
            return const ButtonCard(
              icon: Icons.person_add,
              name: 'New Contact',
            );
          } else {
            return ContactCard(
              chatModel: chats[index - 2],
            );
          }
        },
      ),
    );
  }
}
