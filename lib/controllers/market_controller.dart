import 'package:fl_valrn/dummy_data/dummyProduct.dart';
import 'package:fl_valrn/dummy_data/dummyTrending.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:fl_valrn/model/trending_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MarketController extends GetxController{
  final searchController= TextEditingController();

  var isLoading= true.obs;
  var trendingCard = <TrendingItem>[].obs;
  var productCard = <ProductItem>[].obs;

  final currentIndex = 0.obs;

  void onPageChanged(int index){
    currentIndex.value= index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchTrendings();
    fetchProducts();
  }

  void fetchTrendings() async {
    await Future.delayed(Duration(seconds: 2));
    trendingCard.value = dummyTrending;
    isLoading.value = false;
  }
  void fetchProducts() async {
    await Future.delayed(Duration(seconds: 2));
    productCard.value = dummyProduct;
    isLoading.value = false;
  }
}