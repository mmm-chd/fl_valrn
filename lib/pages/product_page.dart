import 'package:fl_valrn/components/widgets/custom_product_card.dart';
import 'package:fl_valrn/controllers/market_controller.dart';
import 'package:fl_valrn/controllers/product_controller.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetView<MarketController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item= Get.arguments as ProductItem;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx((){
                return CustomProductCard(
                  images: [item.imageUrl], 
                  currentIndex: controller.currentIndex.value, 
                  onPageChanged: controller.onPageChanged, 
                  title: item.title, 
                  subtitle: item.price,
                  onBack: (){},
                  onBookmark: (){},
                  onMore: (){},
                  onShare: (){},);
              })
          
            ],
          ),
        ),
      ),
    );
  }
}