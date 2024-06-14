import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: profileUrl != null
            ? CachedNetworkImage(
          imageUrl: profileUrl!,
        )
            : Image.asset('assets/sample_profile.jpg'),
      ),
    );
  }
}
