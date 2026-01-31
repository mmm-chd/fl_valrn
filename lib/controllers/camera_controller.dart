import 'dart:io';
import 'package:fl_valrn/components/widgets/custom_bottomSheetFix.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/services/ai_detection_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class CameraPageController extends GetxController {
  late CameraController cameraController;
  late Future<void> initializeFuture;
  final ImagePicker _picker = ImagePicker();

  RxBool isFlashOn = false.obs;
  RxBool isReady = false.obs;
  XFile? image;
  String? lastPickedImage; // Untuk simpan image path dari gallery
  final Rx<File?> recentImage = Rx<File?>(null);

  late double minZoom = 1.0;
  late double maxZoom = 1.0;
  late double currentZoom = 1.0;
  late double baseZoom = 1.0;
  Rx<Offset?> focusPoint = Rx<Offset?>(null);

  final CameraDescription camera;

  CameraPageController(this.camera);

  @override
  void onInit() {
    super.onInit();

    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    initializeFuture = cameraController.initialize().then((_) async {
      await initZoom();
      isReady.value = true;
    });
    loadRecentImage();
  }

  Future<void> loadRecentImage() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth) return;

    final List<AssetEntity> assets = await PhotoManager.getAssetListPaged(
      page: 0,
      type: RequestType.image,
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: false),
        ],
      ),
      pageCount: 1,
    );

    if (assets.isNotEmpty) {
      final file = await assets.first.file;
      if (file != null) {
        recentImage.value = file;
      }
    }
  }

  Future<void> takePicture() async {
    if (!cameraController.value.isInitialized) return;
    image = await cameraController.takePicture();
    await cameraController.pausePreview();
  }

  Future<void> toggleFlash() async {
    if (!cameraController.value.isInitialized) return;

    if (isFlashOn.value) {
      await cameraController.setFlashMode(FlashMode.off);
    } else {
      await cameraController.setFlashMode(FlashMode.torch);
    }

    isFlashOn.value = !isFlashOn.value;
  }

  Future<void> _pickFromGallery() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (pickedImage != null) {
      lastPickedImage = pickedImage.path; // Simpan path
    }
  }

  Future<void> initZoom() async {
    minZoom = await cameraController.getMinZoomLevel();
    maxZoom = await cameraController.getMaxZoomLevel();
  }

  Future<void> setFocus(Offset tapPosition, Size screenSize) async {
    final double dx = tapPosition.dx / screenSize.width;
    final double dy = tapPosition.dy / screenSize.height;

    await cameraController.setFocusPoint(Offset(dx, dy));

    focusPoint.value = tapPosition;

    Future.delayed(const Duration(milliseconds: 800), () {
      focusPoint.value = null;
    });
  }

  void onZoomStart() {
    baseZoom = currentZoom;
  }

  Future<void> onZoomUpdate(double scale) async {
    final zoom = (baseZoom * scale).clamp(minZoom, maxZoom);
    currentZoom = zoom;
    await cameraController.setZoomLevel(zoom);
  }

  // Pick dari gallery
  void pickFromGallery() async {
    await _pickFromGallery();
    if (lastPickedImage != null) {
      print('Gallery image picked: $lastPickedImage');
      detectAndNavigate(lastPickedImage!);
    } else {
      print('No image picked from gallery');
    }
  }

  // Detect AI dan navigate
  void detectAndNavigate(String imagePath) async {
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

  void _showSheet({required String text, context}) {
    CustomBottomsheetfix.show(
      context,
      title: '',
      hideHeader: true,
      initialChildSize: 0.34,
      onDismissed: () {},
      children: [
        Row(
          children: [
            Container(width: 100, height: 100),
            CustomText(text: text),
          ],
        ),
      ],
    );
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
