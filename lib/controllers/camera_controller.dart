

import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraPageController extends GetxController {
  late CameraController cameraController;
  late Future<void> initializeFuture;

  RxBool isReady= false.obs;
  XFile? image;

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
  }

  Future<void> takePicture() async {
    if (!cameraController.value.isInitialized) return;
    image= await cameraController.takePicture();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }



}