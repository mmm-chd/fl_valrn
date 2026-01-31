import 'package:camera/camera.dart';
import 'package:fl_valrn/components/widgets/custom_cornerFrame.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/controllers/camera_controller.dart';
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
                child: Obx(() {
                  final isDisabled = controller.isProcessing.value;

                  return Row(
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
                            onPressed: isDisabled
                                ? null
                                : () => controller.pickFromGallery(),
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
                          onPressed: isDisabled
                              ? null
                              : () => controller.pickFromGallery(),
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
                        onPressed: isDisabled
                            ? null
                            : () async {
                                await controller.takePicture();
                                if (controller.image != null) {
                                  controller.detectAndNavigate(
                                    controller.image!.path,
                                  );
                                }
                              },
                        child: const Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(18),
                          backgroundColor: const Color(0xFF2A9134),
                          elevation: 0,
                        ),
                        onPressed: isDisabled ? null : controller.toggleFlash,
                        child: Icon(
                          controller.isFlashOn.value
                              ? Icons.flash_on
                              : Icons.flash_off,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                }),
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
      return const SizedBox.expand(child: ColoredBox(color: Colors.black));
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
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ),
      );
    });
  }
}
