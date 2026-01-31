import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:fl_valrn/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountController extends GetxController {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final facebookC = TextEditingController();
  final instaC = TextEditingController();
  final aboutC = TextEditingController();

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

  Future<void> getprofile(int userId) async{
    try {
      isLoading(true); 

      final profileData = await ProfileService.getProfile(userId);
      nameC.text = profileData?.name ?? '';
      emailC.text = profileData?.email ?? '';
      phoneC.text = profileData?.phone ?? '';
      facebookC.text = profileData?.facebook ?? '';
      instaC.text = profileData?.insta ?? '';
      aboutC.text = profileData?.about ?? '';
    } catch (e) {
        print("Failed to load profile: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile(int userId) async {
    try {
      isLoading(true);
      await ProfileService.updateProfile(userId, {
        'name': nameC.text,
        'email': emailC.text,
        'phone': phoneC.text,
        'facebook': facebookC.text,
        'insta': instaC.text,
        'about': aboutC.text,
      });
      Get.snackbar('Success', 'Profile berhasil diperbarui');
    } catch (e) {
      print("Failed to update profile: $e");
      Get.snackbar('Error', 'Gagal update profile');
    } finally {
      isLoading(false);
    }
  }

}