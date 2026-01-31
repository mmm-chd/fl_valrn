import 'package:fl_valrn/dummy_data/dummyFields.dart';
import 'package:fl_valrn/dummy_data/dummyTrending.dart';
import 'package:fl_valrn/model/artikel_model.dart';
import 'package:fl_valrn/model/fields_model.dart';
import 'package:fl_valrn/model/trending_model.dart';
import 'package:fl_valrn/services/article_service.dart';
import 'package:fl_valrn/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final searchController = TextEditingController();

  var trendingCard = <TrendingItem>[].obs;
  var fieldsCard = <FieldsItem>[].obs;
  var artikelCard = <ArtikelModel>[].obs;
  var isLoadingTrending = true.obs;
  var isLoadingFields = true.obs;
  var isLoadingArticle = true.obs;

  RxString locationText = "Mendeteksi lokasi...".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchTrendings();
    fetchFields();
    fetchArtikel();
    super.onInit();
  }

  Future<void> loadLocation() async {
    final address = await LocationService.getAddress();
    if (address != null) {
      locationText.value = address;
    } else {
      locationText.value = "Lokasi tidak tersedia";
    }
  }

  void fetchTrendings() async {
    await Future.delayed(Duration(seconds: 2));
    trendingCard.value = dummyTrending;
    isLoadingTrending.value = false;
  }

  void fetchFields() async {
    await Future.delayed(Duration(seconds: 2));
    fieldsCard.value = dummyField;
    isLoadingFields.value = false;
  }

  Future<void> fetchArtikel() async {
    try {
      isLoadingArticle.value = true;
      final response = await ArticleService.getAllArticles();
      artikelCard.value = response
          .map((json) => ArtikelModel.fromJson(json))
          .toList();
    } catch (e) {
      print("Error: $e");
      _showError("Error", '$e');
    } finally {
      isLoadingArticle.value = false;
    }
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }
}
