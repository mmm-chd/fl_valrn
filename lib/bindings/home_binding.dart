import 'package:fl_valrn/controllers/home_controller.dart';
import 'package:fl_valrn/controllers/journal_controller.dart';
import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut<HomeController>(()=>HomeController());
      Get.lazyPut<UserController>(()=> UserController());
      Get.lazyPut<JournalController>(()=> JournalController());
  }
  
}