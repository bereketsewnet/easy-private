import 'package:Easy/common/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Easy/pages/CreateGroupPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  UserController userController = Get.put(UserController());

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
    return GetBuilder<UserController>(builder: (_) {
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
                '${userController.allUsersList.length} contacts',
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
          itemCount: userController.allUsersList.length + 2,
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
              return FutureBuilder<List<User>>(
                  future: userController.getAllUsers(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final users = snapshot.data;
                      return SizedBox(
                        height: 900,
                        child: ListView.builder(
                          itemCount: users!.length,
                          itemBuilder: (context, index) {
                            return ContactCard(
                              userModel: users[index],
                            );
                          },
                        ),
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
            }
          },
        ),
      );
    });
  }
}
