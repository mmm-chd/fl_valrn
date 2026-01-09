import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraPageController extends GetxController {
  late CameraController cameraController;
  late Future<void> initializeFuture;
  final ImagePicker _picker= ImagePicker();

  RxBool isFlashOn= false.obs;
  RxBool isReady= false.obs;
  XFile? image;
  final RxString latestImagePath = ''.obs;

  final CameraDescription camera;

  CameraPageController(this.camera);

  @override
  void onInit() {
    super.onInit();

    cameraController= CameraController(
      camera, 
      ResolutionPreset.high,
      enableAudio: false);

    initializeFuture= cameraController.initialize().then((_){
      isReady.value=true;
    });
    loadLatestImage();
  }

    Future<void> loadLatestImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        latestImagePath.value = image.path;
      }
    } catch (_) {}
  }

    Future<void> takePicture() async {
      if (!cameraController.value.isInitialized) return;
      image= await cameraController.takePicture();
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
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (image != null) {
      Get.toNamed(
        '/preview',
        arguments: image.path,
      );
    }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }


    }
}