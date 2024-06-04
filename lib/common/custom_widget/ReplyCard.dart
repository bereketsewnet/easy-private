import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // color: const Color(0xFFDCF8C6),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: const Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  'Hey!, How Are you? How was the last night. I hope you get a lot of knowledge from your senior developer',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  '20:11 AM',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
