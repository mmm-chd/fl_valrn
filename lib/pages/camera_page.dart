import 'package:camera/camera.dart';
import 'package:fl_valrn/components/widgets/custom_cornerFrame.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/controllers/camera_controller.dart';
import 'package:fl_valrn/services/ai_detection_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraPage extends GetView<CameraPageController> {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!controller.isReady.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTapDown: (details) {
                  final screenSize = MediaQuery.of(context).size;
                  controller.setFocus(details.localPosition, screenSize);
                },
                onScaleStart: (_) => controller.onZoomStart(),
                onScaleUpdate: (details) {
                  controller.onZoomUpdate(details.scale);
                },
                child: buildCameraPreview(context),
              ),
            ),
            buildFocusRing(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 35,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: CustomText(
                            text: "GreenScan",
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
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
              child: CornerFrame(radius: 25, cornerLength: 70, strokeWidth: 5),
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
                            backgroundColor: const Color(0xFF2A9134),
                            elevation: 0,
                          ),
                          onPressed: () => _pickFromGallery(),
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
                          iconSize: 20,
                        ),
                        onPressed: () => _pickFromGallery(),
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
                        backgroundColor: const Color(0xFF2A9134),
                      ),
                      onPressed: () async {
                        await controller.takePicture();
                        if (controller.image != null) {
                          _detectAndNavigate(controller.image!.path);
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
                        size: 20,
                        color: Colors.white,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildCameraPreview(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    
    if (!controller.cameraController.value.isInitialized) {
      return const SizedBox.expand(
        child: ColoredBox(color: Colors.black),
      );
    }

    final cameraRatio =
        controller.cameraController.value.previewSize!.height /
        controller.cameraController.value.previewSize!.width;

    return SizedBox.expand(
      child: Transform.scale(
        scale: cameraRatio / deviceRatio,
        child: Center(
          child: AspectRatio(
            aspectRatio: cameraRatio,
            child: CameraPreview(controller.cameraController),
          ),
        ),
      ),
    );
}
  Widget buildFocusRing() {
  return Obx(() {
    final point = controller.focusPoint.value;
    if (point == null) return const SizedBox.shrink();

    return Positioned(
      left: point.dx - 35,
      top: point.dy - 35,
      child: AnimatedScale(
        scale: 1,
        duration: const Duration(milliseconds: 150),
        child: AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 150),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  });
}


  // Pick dari gallery
  void _pickFromGallery() async {
    await controller.pickFromGallery();
    if (controller.lastPickedImage != null) {
      print('Gallery image picked: ${controller.lastPickedImage}');
      _detectAndNavigate(controller.lastPickedImage!);
    } else {
      print('No image picked from gallery');
    }
  }

  // Detect AI dan navigate
  void _detectAndNavigate(String imagePath) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Color(0xff52A068)),
        ),
      ),
      barrierDismissible: false,
    );

    try {
      final apiResponse = await PlantAIService.analyzePlant(
        imagePath: imagePath,
      );

      apiResponse['imagePath'] = imagePath;

      Get.back();

      Get.toNamed(AppRoutes.overviewPage, arguments: apiResponse);
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Gagal',
        'Deteksi AI gagal: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
