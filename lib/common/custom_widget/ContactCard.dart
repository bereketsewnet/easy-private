import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Easy/Model/ChatModel.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey[200],
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
            chatModel.select
                ? const Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(
        chatModel.name!,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        chatModel.status!,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
