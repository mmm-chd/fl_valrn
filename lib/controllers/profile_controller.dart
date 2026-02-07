import 'package:fl_valrn/model/product_model.dart';
import 'package:fl_valrn/model/profile/user_session_model.dart';
import 'package:fl_valrn/services/user_service.dart';
import 'package:fl_valrn/services/market_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final instagramController = TextEditingController();
  final facebookController = TextEditingController();
  final descriptionController = TextEditingController();

  // Observable states
  var isLoading = false.obs;
  var isUpdating = false.obs;
  var isChangingPassword = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  final isExpandInstagram = false.obs;
  final isExpandFacebook = false.obs;
  final isExpandPhone = false.obs;

  var userSession = UserSession.empty().obs;

  // Products data
  var products = <ProductItem>[].obs;
  var isLoadingProducts = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchUserProducts();
  }

  @override
  void onClose() {
    // Dispose all text controllers
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    instagramController.dispose();
    facebookController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  /// Fetch user profile
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      print('🔄 Fetching profile...');

      // Menggunakan AuthService.getProfileModel()
      final result = await UserService.profile();

      userSession.value = UserSession.fromProfileModel(result.user);

      // Populate text controllers with profile data
      _populateControllers();

      print('✅ Profile loaded successfully');
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();

      print('❌ ERROR FETCH PROFILE: $e');

      Get.snackbar(
        'Error',
        'Gagal memuat profil: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch user products
  Future<void> fetchUserProducts() async {
    try {
      isLoadingProducts.value = true;

      print('🔄 Fetching user products...');

      final allProducts = await MarketService.getProducts();

      if (userSession.value.isLoggedIn) {
        final userProducts = allProducts
            .where((product) => product.userId == userSession.value.id)
            .toList();

        products.assignAll(userProducts);
      } else {
        products.clear();
      }
    } catch (e) {
      print('❌ ERROR FETCH USER PRODUCTS: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

  /// Populate text controllers with profile data
  void _populateControllers() {
    final profile = userSession.value;
    nameController.text = profile.name;
    emailController.text = profile.email;
    phoneController.text = profile.phone ?? '-';
    instagramController.text = profile.instagram ?? '-';
    facebookController.text = profile.facebook ?? '-';
    descriptionController.text = profile.description ?? '-';
  }

  /// Logout
  Future<void> logout() async {
    try {
      // Show confirmation dialog
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text('Keluar', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        print('🔄 Logging out...');

        // Menggunakan AuthService.logout()
        await UserService.logout();

        print('✅ Logged out successfully');
        userSession.value = UserSession.empty();
        // Clear profile data
        products.clear();
      }
    } catch (e) {
      print('❌ ERROR LOGOUT: $e');

      Get.snackbar(
        'Error',
        'Gagal logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Refresh profile and products
  Future<void> refreshProfile() async {
    await Future.wait([fetchProfile(), fetchUserProducts()]);
  }

  /// Check if there are unsaved changes
  bool hasUnsavedChanges() {
    if (!userSession.value.isLoggedIn) return false;
    final profile = userSession.value;
    return nameController.text != profile.name ||
        emailController.text != profile.email ||
        phoneController.text != (profile.phone ?? '') ||
        instagramController.text != (profile.instagram ?? '') ||
        facebookController.text != (profile.facebook ?? '') ||
        descriptionController.text != (profile.description ?? '');
  }

  void clickExpandFacebook() {
    isExpandFacebook.value = !isExpandFacebook.value;
  }

  void clickExpandInstagram() {
    isExpandInstagram.value = !isExpandInstagram.value;
  }

  void clickExpandPhone() {
    isExpandPhone.value = !isExpandPhone.value;
  }
}
