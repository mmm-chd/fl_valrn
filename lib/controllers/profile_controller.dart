import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:fl_valrn/services/auth_service.dart';
import 'package:fl_valrn/services/market_service.dart';
import 'package:fl_valrn/services/myproducts_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final userC = Get.find<UserController>();
  final products = <ProductItem>[].obs;
  final isLoading = false.obs;

  
  Future<void> logout() async{
    await AuthService.logout();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever<int?>(userC.id, (id) {
      if (id != null) {
        fetchMyProducts(id);
      }
    });
  }

  Future<void> fetchMyProducts(int userId) async {
    try {
      isLoading.value= true;
      final result = await MyproductsService.getMyProducts(userId);
      products.assignAll(result);

    } catch (e) {
      print('ERROR FETCH PRODUCT: $e');
      Get.snackbar(
        
        'Error', 
        'Gagal mengambil produk',
        snackPosition: SnackPosition.BOTTOM);
    } finally{
      isLoading.value = false;
    }
  }
}