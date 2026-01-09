import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/pages/camera_page.dart';
import 'package:fl_valrn/pages/fields_page.dart';
import 'package:fl_valrn/pages/home_page.dart';
import 'package:fl_valrn/pages/market_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var currentIndex = 0.obs;
  final List<Widget> pages = [
    HomePage(),
    FieldsPage(),
    Container(),
    MarketPage(),
  ];

  void changeIndex(int index) {
    if (index == 2) {
    Get.toNamed(AppRoutes.cameraPage);
    return;
  }
    currentIndex.value = index;
    Get.back();
  }
}
