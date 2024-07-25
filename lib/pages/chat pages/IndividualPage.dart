import 'package:Easy/Model/PrivateChatModel.dart';
import 'package:Easy/provider/controller/ChatController.dart';
import 'package:Easy/provider/controller/UserController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Easy/common/utils/colors.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:get/get.dart';
import '../../Model/UserModel.dart';
import '../../common/SocketConnection/SocketMethods.dart';
import '../../common/custom_widget/OwnMessageCard.dart';
import '../../common/custom_widget/ProfileCircle.dart';
import '../../common/custom_widget/ReplyCard.dart';
import '../Screens/CameraScreen.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key, required this.userModel});

  final User userModel;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool showEmoji = false;
  SocketMethods socketMethods = Get.find();
  ChatController chatController = Get.find();
  UserController userController = Get.find();
  List<dynamic> chatMessages = [];

  // to change mic button to send button to set text
  bool sendButton = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    socketMethods.sendPrivateMessageSuccess();
    socketMethods.errorReceiver(context);

    getHistoryMessages();
    updateNewMessage();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
  }

  @override
  void dispose() {
   _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/chat_bg.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  const SizedBox(width: 2),
                  ProfileCircle(
                    profileUrl: widget.userModel.profileUrl,
                    radius: 20,
                  ),
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.userModel.firstName}  ${widget.userModel.lastName}',
                    style: const TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Last seen today at 10:12',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.videocam),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call),
              ),
              PopupMenuButton(onSelected: (value) {
                if (kDebugMode) {
                  print(value);
                }
              }, itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'View Contact',
                    child: Text('View Contact'),
                  ),
                  const PopupMenuItem(
                    value: 'Media, links, and docs',
                    child: Text('Media, links, and docs'),
                  ),
                  const PopupMenuItem(
                    value: 'Whatsapp web',
                    child: Text('Whatsapp web'),
                  ),
                  const PopupMenuItem(
                    value: 'Started message',
                    child: Text('Started message'),
                  ),
                  const PopupMenuItem(
                    value: 'Mute Notification',
                    child: Text('Mute Notification'),
                  ),
                  const PopupMenuItem(
                    value: 'Wallpaper',
                    child: Text('Wallpaper'),
                  ),
                ];
              }),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    child: GetBuilder<SocketMethods>(
                      builder: (_) {
                        return StreamBuilder<List<dynamic>>(
                          stream: socketMethods.messageStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(child: Text('No messages'));
                            } else {
                              List<dynamic> chatHistory = snapshot.data!;
                              return ListView.builder(
                                itemCount: chatHistory.length,
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final eachMessage = chatHistory[index];
                                  if (eachMessage.sender ==
                                      userController.currentUser!.id) {
                                    return OwnMessageCard(
                                        messageData: eachMessage);
                                  } else {
                                    return ReplyCard(messageData: eachMessage);
                                  }
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Card(
                                margin: const EdgeInsets.only(
                                  left: 2,
                                  right: 2,
                                  bottom: 9,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextFormField(
                                  controller: textController,
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          showEmoji = !showEmoji;
                                        });
                                      },
                                      icon: Icon(
                                        showEmoji
                                            ? Icons.keyboard_double_arrow_down
                                            : Icons.emoji_emotions,
                                        color: secondary,
                                      ),
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  bottomSheet(),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.attach_file,
                                            color: secondary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            getHistoryMessages();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (builder) =>
                                                    const CameraScreen(),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    hintText: 'Type a message',
                                    contentPadding: const EdgeInsets.all(5),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 2,
                                right: 5,
                                bottom: 9,
                              ),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: primary,
                                child: sendButton
                                    ? IconButton(
                                        onPressed: () {
                                          // sending the message
                                          sendMessage(textController.text);
                                          // scroll to button when sending message
                                         // _scrollToBottomAnimated();
                                          // and return to mic button icon
                                          setState(() {
                                            sendButton = false;
                                          });
                                          // clearing textFild
                                          textController.clear();
                                        },
                                        icon: const Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.mic,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        showEmoji ? emojiSelect() : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (showEmoji) {
                  setState(() {
                    showEmoji = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.insert_drive_file,
                    Colors.indigo,
                    'Document',
                    () {},
                  ),
                  const SizedBox(width: 35),
                  iconCreation(
                    Icons.camera_alt,
                    Colors.pink,
                    'Camera',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => const CameraScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 35),
                  iconCreation(
                    Icons.insert_photo,
                    Colors.purple,
                    'Gallery',
                    () {},
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.headset,
                    Colors.orange,
                    'Audio',
                    () {},
                  ),
                  const SizedBox(width: 35),
                  iconCreation(
                    Icons.location_pin,
                    Colors.teal,
                    'Location',
                    () {},
                  ),
                  const SizedBox(width: 35),
                  iconCreation(
                    Icons.person,
                    Colors.blue,
                    'Contact',
                    () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icon, Color color, String text, void Function()? onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
          ),
        )
      ],
    );
  }

  Widget emojiSelect() {
    return Container(
      child: EmojiPicker(
        textEditingController: textController,
        onEmojiSelected: (category, emoji) {
          String value = textController.toString().trim();
          if (value.isNotEmpty) {
            setState(() {
              sendButton = true;
            });
          } else {
            setState(() {
              sendButton = false;
            });
          }
        },
      ),
    );
  }

  void _scrollToBottomAnimated() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void sendMessage(String messageText) {
    final message = PrivateChatModel(
      message: messageText,
      sender: userController.currentUser!.id,
      receiver: widget.userModel.id,
      timeStamp: 'serverTime Stamp Assign',
      isSeen: false,
    );
     socketMethods.sendPrivateMessage(message);
     _scrollToBottomAnimated();
  }

  void getHistoryMessages() async {

  }

  void updateNewMessage() async {
    socketMethods.getAllOneToOneChatMessageGivenUser(
      userController.currentUser!.id,
      widget.userModel.id,
    );
    socketMethods.getAllOneToOneChatGivenUserListener();
    _scrollToBottom();

  }
}