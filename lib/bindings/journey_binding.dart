import 'package:fl_valrn/controllers/journey_controller.dart';
import 'package:get/get.dart';

class JourneyBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<JourneyController>(()=>JourneyController());
  }
}