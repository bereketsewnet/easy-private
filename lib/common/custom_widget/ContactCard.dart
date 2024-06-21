import 'package:Easy/Model/UserModel.dart';
import 'package:Easy/common/custom_widget/ProfileCircle.dart';
import 'package:Easy/pages/chat%20pages/IndividualPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.userModel});

  final User userModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => IndividualPage(
            userModel: userModel,
          ),
        );
      },
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: ProfileCircle(
            profileUrl: userModel.profileUrl,
            radius: 23,
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
      ),
    );
  }
}
