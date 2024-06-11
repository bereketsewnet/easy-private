import 'package:Easy/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Easy/Model/ChatModel.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.userModel});

  final User userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 50,
        width: 50,
        child: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.blueGrey[200],
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      title: Text(
        '${userModel.firstName} ${userModel.lastName}',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        userModel.userType,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
