import 'package:fl_valrn/controllers/camera_controller.dart';
import 'package:get/get.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CameraController>(()=>CameraController());
  }
  
}