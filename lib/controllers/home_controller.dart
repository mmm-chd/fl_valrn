import 'package:fl_valrn/dummy_data/dummyArtikel.dart';
import 'package:fl_valrn/dummy_data/dummyFields.dart';
import 'package:fl_valrn/dummy_data/dummyTrending.dart';
import 'package:fl_valrn/model/artikel_model.dart';
import 'package:fl_valrn/model/fields_model.dart';
import 'package:fl_valrn/model/trending_model.dart';
import 'package:fl_valrn/services/location_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final searchController= TextEditingController();

  var trendingCard = <TrendingItem>[].obs;
  var fieldsCard = <FieldsItem>[].obs;
  var artikelCard = <ArtikelItem>[].obs;
  var isLoading= true.obs;

  RxString locationText= "Mendeteksi lokasi...".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchTrendings();
    fetchFields();
    fetchArtikel();
    super.onInit();
  }

  Future<void> loadLocation() async{
    final address= await LocationService.getAddress();
    if (address != null) {
      locationText.value=address;
    } else {
      locationText.value="Lokasi tidak tersedia";
    }

  }

  void fetchTrendings() async {
    await Future.delayed(Duration(seconds: 2));
    trendingCard.value = dummyTrending;
    isLoading.value = false;
  }
  void fetchFields() async {
    await Future.delayed(Duration(seconds: 2));
    fieldsCard.value = dummyField;
    isLoading.value = false;
  }
  void fetchArtikel() async {
    await Future.delayed(Duration(seconds: 2));
    artikelCard.value = dummyArtikel;
    isLoading.value = false;
  }
}