import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:fl_valrn/model/profile_model.dart';
import 'package:fl_valrn/services/auth_service.dart';
import 'package:fl_valrn/services/myproducts_service.dart';
import 'package:fl_valrn/services/profile_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final userC = Get.find<UserController>();
  final products = <ProductItem>[].obs;
  var profile = Rxn<ProfileModel>();
  final isMyProfile = true.obs;
  final isLoading = false.obs;

  Future<void> logout() async {
    await AuthService.logout();
  }

  @override
  void onInit() {
    super.onInit();

    // Tunggu sampai userC.id tidak null
    ever<int?>(userC.id, (id) {
      if (id != null) {
        fetchProfile(id);
        fetchMyProducts(id);
      }
    });

    // Jika id sudah ada saat init, langsung fetch
    if (userC.id.value != null) {
      fetchProfile(userC.id.value!);
      fetchMyProducts(userC.id.value!);
    }
  }

  void fetchProfile(int userId) async {
    try {
      isLoading(true);
      profile.value = await ProfileService.getProfile(userId);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void updateProfile(
    int userId,
    String name,
    String email,
    String phone,
    String insta,
    String facebook,
    String about,
  ) async {
    isLoading(true);
    bool success = await ProfileService.updateProfile(userId, {
      'name': name,
      'email': email,
      'phone': phone,
      'instagram': insta,
      'facebook': facebook,
      'description': about,
    });
    if (success) fetchProfile(userId);
    isLoading(false);
  }

  Future<void> fetchMyProducts(int userId) async {
    try {
      isLoading.value = true;
      final result = await MyproductsService.getMyProducts(userId);
      products.assignAll(result);
    } catch (e) {
      print('ERROR FETCH PRODUCT: $e');
      Get.snackbar(
        'Error',
        'Gagal mengambil produk',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
