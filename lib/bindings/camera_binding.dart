import 'package:camera/camera.dart';
import 'package:fl_valrn/controllers/camera_controller.dart';
import 'package:get/get.dart';

class CameraBinding extends Bindings {
  final CameraDescription camera;

  CameraBinding(this.camera);

  @override
  void dependencies() {
    Get.lazyPut<CameraPageController>(
      ()=> CameraPageController(camera)
    );
  }
  
}