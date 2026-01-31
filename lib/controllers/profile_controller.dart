import 'package:fl_valrn/model/product_model.dart';
import 'package:fl_valrn/model/profile_model.dart';
import 'package:fl_valrn/services/auth_service.dart';
import 'package:fl_valrn/services/market_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final instagramController = TextEditingController();
  final facebookController = TextEditingController();
  final descriptionController = TextEditingController();

  // Password Controllers
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable states
  var isLoading = false.obs;
  var isUpdating = false.obs;
  var isChangingPassword = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // Profile data
  Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);

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
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
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
      final result = await AuthService.getProfileModel();
      profile.value = result;

      // Populate text controllers with profile data
      _populateControllers(result);

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

      // Get all products
      final allProducts = await MarketService.getProducts();

      // Filter products by current user ID
      if (profile.value != null) {
        final userProducts = allProducts
            .where((product) => product.userId == profile.value!.id)
            .toList();

        products.assignAll(userProducts);
        print('✅ Found ${userProducts.length} products for user');
      } else {
        products.clear();
      }
    } catch (e) {
      print('❌ ERROR FETCH USER PRODUCTS: $e');
      // Don't show error snackbar for products, just log it
    } finally {
      isLoadingProducts.value = false;
    }
  }

  /// Populate text controllers with profile data
  void _populateControllers(ProfileModel profileData) {
    nameController.text = profileData.name;
    emailController.text = profileData.email;
    phoneController.text = profileData.phone ?? '';
    instagramController.text = profileData.instagram ?? '';
    facebookController.text = profileData.facebook ?? '';
    descriptionController.text = profileData.description ?? '';
  }

  /// Update profile
  Future<void> updateProfile() async {
    try {
      // Validation
      if (nameController.text.trim().isEmpty) {
        Get.snackbar(
          'Peringatan',
          'Nama tidak boleh kosong',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (emailController.text.trim().isEmpty) {
        Get.snackbar(
          'Peringatan',
          'Email tidak boleh kosong',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Email validation
      if (!GetUtils.isEmail(emailController.text.trim())) {
        Get.snackbar(
          'Peringatan',
          'Format email tidak valid',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      isUpdating.value = true;

      print('🔄 Updating profile...');

      // Menggunakan AuthService.updateProfile()
      final result = await AuthService.updateProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim().isNotEmpty
            ? phoneController.text.trim()
            : null,
        instagram: instagramController.text.trim().isNotEmpty
            ? instagramController.text.trim()
            : null,
        facebook: facebookController.text.trim().isNotEmpty
            ? facebookController.text.trim()
            : null,
        description: descriptionController.text.trim().isNotEmpty
            ? descriptionController.text.trim()
            : null,
      );

      profile.value = result;

      print('✅ Profile updated successfully');

      Get.snackbar(
        'Berhasil',
        'Profil berhasil diperbarui',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFF2A9134),
        colorText: Colors.white,
      );
    } catch (e) {
      print('❌ ERROR UPDATE PROFILE: $e');

      Get.snackbar(
        'Error',
        'Gagal memperbarui profil: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  /// Change password
  Future<void> changePassword() async {
    try {
      // Validation
      if (oldPasswordController.text.trim().isEmpty) {
        Get.snackbar(
          'Peringatan',
          'Password lama tidak boleh kosong',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (newPasswordController.text.trim().isEmpty) {
        Get.snackbar(
          'Peringatan',
          'Password baru tidak boleh kosong',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (newPasswordController.text.length < 8) {
        Get.snackbar(
          'Peringatan',
          'Password baru minimal 8 karakter',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (newPasswordController.text != confirmPasswordController.text) {
        Get.snackbar(
          'Peringatan',
          'Konfirmasi password tidak sesuai',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      isChangingPassword.value = true;

      print('🔄 Changing password...');

      // Menggunakan AuthService.changePassword()
      await AuthService.changePassword(
        oldPassword: oldPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      // Clear password fields
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      print('✅ Password changed successfully');

      Get.snackbar(
        'Berhasil',
        'Password berhasil diubah',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFF2A9134),
        colorText: Colors.white,
      );
    } catch (e) {
      print('❌ ERROR CHANGE PASSWORD: $e');

      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isChangingPassword.value = false;
    }
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
        await AuthService.logout();

        print('✅ Logged out successfully');

        // Clear profile data
        profile.value = null;
        products.clear();

        // Navigate to login page
        // Get.offAllNamed('/login'); // Uncomment dan sesuaikan route

        Get.snackbar(
          'Berhasil',
          'Anda telah keluar',
          snackPosition: SnackPosition.BOTTOM,
        );
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

  /// Reset form to original profile data
  void resetForm() {
    if (profile.value != null) {
      _populateControllers(profile.value!);
    }
  }

  /// Check if there are unsaved changes
  bool hasUnsavedChanges() {
    if (profile.value == null) return false;

    return nameController.text != profile.value!.name ||
        emailController.text != profile.value!.email ||
        phoneController.text != (profile.value!.phone ?? '') ||
        instagramController.text != (profile.value!.instagram ?? '') ||
        facebookController.text != (profile.value!.facebook ?? '') ||
        descriptionController.text != (profile.value!.description ?? '');
  }
}
