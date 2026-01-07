import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraController extends GetxController {
  final ImagePicker picker = ImagePicker();
  Rx<File?> image= Rx<File?>(null);  
  RxBool isLoading = false.obs;

  Future<void> takePhoto() async {
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80);

    if (photo != null) {
      image.value= File(photo.path);
    }
  }
}