import 'dart:io';
import 'dart:ui';
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
          const OrderOption(
            type: OrderOptionType.createDate,
            asc: false,
          ),
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

  Future<void> pickFromGallery() async {
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
  
  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}