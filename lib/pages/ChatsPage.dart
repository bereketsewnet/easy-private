import 'package:Easy/common/SnackBar/lower_snack_bar.dart';
import 'package:Easy/common/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:Easy/pages/SelectContactPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../Model/ChatModel.dart';
import '../Model/UserModel.dart';
import '../common/custom_widget/CustomCard.dart';
import '../provider/controller/UserController.dart';

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
  UserController userController = Get.put(UserController());
  LowerSnackBar lowerSnackBar = Get.find();

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  void getAllUsers() async {
    await userController.getAllUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserController>(
        builder: (_) {
          return FutureBuilder<List<User>>(
              future: userController.getAllUsers(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final users = snapshot.data;
                  return ListView.builder(
                    itemCount: users!.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        userModel: users[index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Text'));
                } else {
                  return const SpinKitCircle(
                    color: primary,
                    size: 50,
                  );
                }
              });
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
              builder: (context) => const SelectContactPage(),
            ),
          );
        },
      ),
    );
  }
}
