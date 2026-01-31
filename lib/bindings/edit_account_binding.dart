import 'package:fl_valrn/controllers/edit_account_controller.dart';
import 'package:get/get.dart';

class EditAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAccountController>(() => EditAccountController());
  }
}
