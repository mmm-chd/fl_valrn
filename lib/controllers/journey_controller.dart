import 'dart:ui';

import 'package:fl_valrn/model/fields_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JourneyController extends GetxController{
  final selectedMonth = DateTime.now().month.obs;
    
  void changeMonth(int month){
    selectedMonth.value=month;
  }

  late FieldsItem field;
  final journeys =<PlantItem>[].obs;

  List<PlantItem> get filteredJourneys {
    final result = journeys
        .where((j) =>
            j.createdAt != null &&
            j.createdAt!.month == selectedMonth.value)
        .toList();

    result.sort(
      (a, b) => a.createdAt!.compareTo(b.createdAt!),
    );

    return result;
  }

  Map<DateTime, List<PlantItem>> get groupedByDate {
    final Map<DateTime, List<PlantItem>> grouped = {};

    for (final journey in filteredJourneys) {
      if (journey.createdAt == null) continue;

      final dateOnly = DateTime(
        journey.createdAt!.year,
        journey.createdAt!.month,
        journey.createdAt!.day,
      );

      grouped.putIfAbsent(dateOnly, () => []);
      grouped[dateOnly]!.add(journey);
    }

    return grouped;
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
    if (status == "safe") return "Hari ini tanaman dalam kondisi baik tanpa kendala.";
    if (status == "warning") return "Hari ini tanaman terlihat kurang sehat.";
    return "Hari ini tanaman sepertinya mengalami masalah";
  }

  String safeStatus(String? status) {
    return status ?? 'Status belum tersedia';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    field = Get.arguments as FieldsItem;
    journeys.assignAll(field.plants);
  }
}