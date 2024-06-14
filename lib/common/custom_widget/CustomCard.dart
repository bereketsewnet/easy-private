import 'package:Easy/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:Easy/Model/ChatModel.dart';
import 'package:Easy/pages/chat%20pages/IndividualPage.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.userModel});

  final User userModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              userModel: userModel,
            ),
          ),
        );
      },
      child: ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueGrey,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 35,
          ),
        ),
        title: Text(
          '${userModel.firstName}  ${userModel.lastName}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.done_all),
            const SizedBox(width: 3),
            Text(
              userModel.userType,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        trailing: const Text(
          '11:02',
        ),
      ),
    );
  }
}
