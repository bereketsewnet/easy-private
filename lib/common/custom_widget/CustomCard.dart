import 'package:flutter/material.dart';
import 'package:Easy/Model/ChatModel.dart';
import 'package:Easy/pages/chat%20pages/IndividualPage.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              chatModel: chatModel,
            ),
          ),
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueGrey,
          child: chatModel.isGroup!
              ? const Icon(
                  Icons.groups,
                  color: Colors.white,
                  size: 35,
                )
              : const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 35,
                ),
        ),
        title: Text(
          chatModel.name ?? '',
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
              chatModel.currentMessage ?? '',
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        trailing: Text(
          chatModel.time ?? '',
        ),
      ),
    );
  }
}
