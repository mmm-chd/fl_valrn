import 'package:camera/camera.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/controllers/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraPage extends GetView<CameraPageController> {
  CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        if (!controller.isReady.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            CameraPreview(controller.cameraController),

            Positioned(
              child: Center(
                child: GestureDetector(
                  onTap: () async{
                    await controller.takePicture();
                    if (controller.image !=null) {
                      Get.toNamed(
                        AppRoutes.previewPage,
                        arguments: controller.image!.path,
                      );
                    }
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4)
                    ),
                  ),
                ),
              ))
          ],
        );
      })
    );
  }
}