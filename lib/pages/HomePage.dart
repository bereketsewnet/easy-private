import 'package:Easy/common/SocketConnection/SocketMethods.dart';
import 'package:Easy/common/custom_widget/ProfileCircle.dart';
import 'package:Easy/provider/controller/AuthController.dart';
import 'package:Easy/provider/controller/UserController.dart';
import 'package:flutter/material.dart';
import 'package:Easy/pages/CallHistoryPage.dart';
import 'package:Easy/pages/CameraPage.dart';
import 'package:Easy/pages/ChatsPage.dart';
import 'package:Easy/pages/StatusPage.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AuthController authController = Get.find();
  UserController userController = Get.find();

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this, initialIndex: 1);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 105,
        titleSpacing: 0,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu_rounded),
            ),
            ProfileCircle(
              profileUrl: userController.currentUser.profileUrl,
              radius: 25,
            ),
            // CircleProfile(),
          ],
        ),
        title: Text(userController.currentUser.firstName),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton(onSelected: (value) {
            if (value == 'logout') {
              authController.logOut(context);
            } else {
              print(value);
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'New group',
                child: Text('New group'),
              ),
              const PopupMenuItem(
                value: 'New broadcast',
                child: Text('New broadcast'),
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
                value: 'Settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ];
          }),
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.white,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Text(
                'CHATS',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'GROUP',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'CHANNEL',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'STATUS',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'CALLS',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CameraPage(),
          ChatPage(),
          Text('GROUP CHAT'),
          Text('CHANNEL CHAT'),
          StatusPage(),
          CallHistoryPage(),
        ],
      ),
    );
  }
}
