import 'package:fl_valrn/controllers/field_controller.dart';
import 'package:get/get.dart';

class FieldsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<FieldsController>(()=>FieldsController());
  }
  
}