import 'package:fl_valrn/controllers/overview_controller.dart';
import 'package:get/get.dart';

class OverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OverviewController>(() => OverviewController());
  }
}
