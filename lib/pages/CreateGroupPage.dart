import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/ChatModel.dart';
import '../Model/UserModel.dart';
import '../common/custom_widget/AvatarCard.dart';
import '../common/custom_widget/ContactCard.dart';
import '../provider/controller/UserController.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

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
List<User> users = [
  User(
    id: 'id',
    firstName: 'firstName',
    lastName: 'lastName',
    email: 'email',
    password: 'password',
    phoneNumber: 'phoneNumber',
    userType: 'userType',
  ),
];
List<User> groupOfUsers = [];

class _CreateGroupPageState extends State<CreateGroupPage> {
  UserController userController = Get.find();

  @override
  void initState() {
// getAllUsers();
    super.initState();
  }

  void getAllUsers() async {
    users = await userController.getAllUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Group',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Add participants',
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
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: users.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groupOfUsers.isNotEmpty ? 90 : 10,
                  );
                }
                return InkWell(onTap: () {
                  if (users[index - 1].select == false) {
                    setState(() {
                      users[index - 1].select = true;
                      groupOfUsers.add(users[index - 1]);
                    });
                  } else {
                    setState(() {
                      users[index - 1].select = false;
                      groupOfUsers.remove(users[index - 1]);
                    });
                  }
                }, child: GetBuilder<UserController>(builder: (_) {
                  return ContactCard(
                    userModel: userController.allUsersList[index - 1],
                  );
                }));
              }),
          groupOfUsers.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            if (users[index].select) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    groupOfUsers.remove(users[index]);
                                    users[index].select = false;
                                  });
                                },
                                child: AvatarCard(
                                  contact: users[index],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    const Divider(thickness: 1),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
