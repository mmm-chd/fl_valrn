import 'package:fl_valrn/controllers/market_controller.dart';
import 'package:get/get.dart';

class MarketBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MarketController>(()=> MarketController());
  }

}