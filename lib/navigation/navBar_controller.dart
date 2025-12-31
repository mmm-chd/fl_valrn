import 'package:fl_valrn/pages/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var currentIndex = 0.obs;
  final List<Widget> pages = [HomePage()];

  void changeIndex(int index) {
    currentIndex.value = index;
    Get.back();
  }
}
