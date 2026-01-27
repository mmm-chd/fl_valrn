import 'dart:io';
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

    initializeFuture = cameraController.initialize().then((_) {
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

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}