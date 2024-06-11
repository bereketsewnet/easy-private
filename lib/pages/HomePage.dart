import 'package:Easy/provider/controller/AuthController.dart';
import 'package:Easy/provider/controller/UserController.dart';
import 'package:flutter/foundation.dart';
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
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userController.currentUser.firstName),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton(onSelected: (value) {
            if(value == 'logout') {
              authController.logOut(context);
            }else {
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
          controller: _tabController,
          indicatorColor: Colors.white,
          dividerColor: Colors.transparent,
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
          StatusPage(),
          CallHistoryPage(),
        ],
      ),
    );
  }
}
