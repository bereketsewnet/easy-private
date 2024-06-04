import 'package:flutter/material.dart';
import '../Model/ChatModel.dart';
import '../common/custom_widget/AvatarCard.dart';
import '../common/custom_widget/ContactCard.dart';

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
List<ChatModel> groups = [];

class _CreateGroupPageState extends State<CreateGroupPage> {
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
                itemCount: chats.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: groups.length > 0 ? 90 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      if (chats[index - 1].select == false) {
                        setState(() {
                          chats[index - 1].select = true;
                          groups.add(chats[index - 1]);
                        });
                      } else {
                        setState(() {
                          chats[index - 1].select = false;
                          groups.remove(chats[index - 1]);
                        });
                      }
                    },
                    child: ContactCard(
                      chatModel: chats[index - 1],
                    ),
                  );
                }),
            groups.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              if (chats[index].select) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      groups.remove(chats[index]);
                                      chats[index].select = false;
                                    });
                                  },
                                  child: AvatarCard(
                                    contact: chats[index],
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
        ));
  }
}
