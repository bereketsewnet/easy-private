import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../SnackBar/lower_snack_bar.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({
    super.key,
    required this.profileUrl,
    required this.radius,
  });

  final String? profileUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    LowerSnackBar lowerSnackBar = Get.find();
    return profileUrl != null
        ? CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            backgroundImage: CachedNetworkImageProvider(
              profileUrl!,
              errorListener: (error) => lowerSnackBar.failureSnackBar(
                context,
                'Image Not Loading!',
              ),
            ),
          )
        : CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage('assets/sample_profile.jpg'),
          );
  }
}
