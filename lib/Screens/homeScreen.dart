import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Easy/Screens/CallScreen.dart';
import 'package:Easy/pages/CameraPage.dart';
import 'package:Easy/pages/ChatsPage.dart';
import 'package:Easy/pages/StatusPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whatsapp Clone'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton(onSelected: (value) {
            if (kDebugMode) {
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
          CallScreen(),
        ],
      ),
    );
  }
}
