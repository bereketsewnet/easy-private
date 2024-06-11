import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Easy/pages/CreateGroupPage.dart';
import 'package:get/get.dart';

import '../Model/ChatModel.dart';
import '../Model/UserModel.dart';
import '../common/custom_widget/ButtomCard.dart';
import '../common/custom_widget/ContactCard.dart';
import '../provider/controller/UserController.dart';

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
  List<User> allUsers = [];
  
  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  void getAllUsers() async{
    UserController userController = Get.put(UserController());
   final users = await userController.getAllUsers(context);
   if(users != null) {
     setState(() {
       allUsers = users;
     });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Contact',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${allUsers.length} contacts',
              style: const TextStyle(
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
        itemCount: allUsers.length + 2,
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
              userModel: allUsers[index - 2],
            );
          }
        },
      ),
    );
  }
}
