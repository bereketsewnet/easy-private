import 'dart:io';
import 'package:Easy/common/utils/android_permission.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RepositoryController extends GetxController {
  AndroidPermission androidPermission = Get.put(AndroidPermission());
  XFile? _pickedFile;

  XFile? get pickedFile => _pickedFile;

  Future<void> selectImageFromGallery() async {
    androidPermission.checkPermissionsImage();
    final picker = ImagePicker();
    _pickedFile = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> selectAndUploadVideo(String userId, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      final videoFile = File(pickedFile.path);
    }
  }

// generate roomId
  String generateRoomId(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    return ids.join('_');
  }

}
