import 'package:get/get.dart';
import '../controllers/camera_controller.dart';
import '../main.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraPageController>(
      () => CameraPageController(cameras.first),
    );
  }
}