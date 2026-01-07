import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/controllers/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CameraPage extends GetView<CameraController> {
  CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ngetes"),),
      body: Center(
        child: ElevatedButton(onPressed: () async {
          await controller.takePhoto();
          if (controller.image.value != null) {
            Get.toNamed(AppRoutes.previewPage);
          }
        }, child: const Text("Ambil Foto")),
      ),
    );
  }
}