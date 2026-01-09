import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fl_valrn/components/widgets/custom_cornerFrame.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
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
            Positioned.fill(
              child: CameraPreview(controller.cameraController),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(icon: const Icon(Icons.close, size: 35, color: Colors.white), onPressed: () { Get.back(); },),
                      Expanded(
                        child: Center(
                          child: CustomText(
                            text: "GreenScan",
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Icon(Icons.info, size: 28, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            const Center(
              child: CornerFrame(
                radius: 25,
                cornerLength: 70,
                strokeWidth: 5,
              ),
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   Obx(() {
                      if (controller.recentImage.value == null) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(18),
                            backgroundColor: Colors.white.withOpacity(0.25),
                            elevation: 0,
                          ),
                          onPressed: controller.pickFromGallery,
                          child: const Icon(
                            Icons.photo_library,
                            color: Colors.white,
                          ),
                        );
                      }

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          backgroundColor: Colors.white.withOpacity(0.25),
                          elevation: 0,
                        ),
                        onPressed: controller.pickFromGallery,
                        child: ClipOval(
                          child: Image.file(
                            controller.recentImage.value!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(18),
                        backgroundColor: const Color(0xFF2A9134)
                      ),
                      onPressed: () async {
                        await controller.takePicture();
                        if (controller.image != null) {
                          Get.toNamed(
                            AppRoutes.previewPage,
                            arguments: controller.image!.path,
                          );
                        }
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    
                    Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(18),
                        backgroundColor: const Color(0xFF2A9134),
                        elevation: 0,
                      ),
                      onPressed: controller.toggleFlash,
                      child: Icon(
                        controller.isFlashOn.value
                            ? Icons.flash_on
                            : Icons.flash_off,
                        size: 28,
                        color: Colors.white,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        );
      })
    );
  }
}