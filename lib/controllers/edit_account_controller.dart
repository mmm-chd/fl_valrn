import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:fl_valrn/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountController extends GetxController {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final facebookC = TextEditingController();
  final instaC = TextEditingController();
  final descC = TextEditingController();

  var isLoading = false.obs;
  final userC = Get.find<UserController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final id = userC.id.value;
    if (id != null) {
      getprofile(id);
    } else {
      print("User ID belum tersedia");
    }
  }

  Future<void> getprofile(int userId) async {
    try {
      isLoading(true);

      final profileData = await UserService.profile();
      final data = profileData.user;
      nameC.text = data.name;
      emailC.text = data.email;
      phoneC.text = data.phone;
      facebookC.text = data.facebook;
      instaC.text = data.instagram;
      descC.text = data.description ?? '';
    } catch (e) {
      print("Failed to load profile: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading(true);
      await UserService.updateProfile(
        name: nameC.text.toString().trim(),
        email: emailC.text.toString().trim(),
        description: descC.text.toString(),
        phone: phoneC.text.toString().trim(),
        instagram: instaC.text.toString(),
        facebook: facebookC.text.toString(),
      );
      Get.snackbar('Success', 'Profile berhasil diperbarui');
    } catch (e) {
      print("Failed to update profile: $e");
      Get.snackbar('Error', 'Gagal update profile');
    } finally {
      isLoading(false);
    }
  }
}
