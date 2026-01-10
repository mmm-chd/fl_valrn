import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JourneyController extends GetxController{
  final selectedMonth = DateTime.now().month.obs;
    
  void changeMonth(int month){
    selectedMonth.value=month;
  }

  Color titleColor(String? status){
    if (status == "safe") return Color(0xFF054A29);
    if (status == "warning") return Color(0xffC28014);
    return Color(0xff991624);
  }
  Color statusColor(String? status){
    if (status == "safe") return Color(0xFF054A29);
    if (status == "warning") return Color(0xffC28014);
    return Color(0xff991624);
  }
  Color latinTitleColor(String? status){
    if (status == "safe") return Color(0xff2A9134);
    if (status == "warning") return Color(0xffEDAE47);
    return Color(0xffBA3A48);
  }
  Color backgroundColor(String? status){
    if (status == "safe") return Color(0xff8CD196);
    if (status == "warning") return Color(0xffFEE7C1);
    return Color(0xffF47988);
  }

  String statusText(String?status){
    if (status == "safe") return "Sehat";
    if (status == "warning") return "Berpotensi";
    return "Penyakitan";
  }

  String safeStatus(String? status) {
    return status ?? 'Status belum tersedia';
  }
}