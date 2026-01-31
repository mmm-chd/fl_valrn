import 'package:fl_valrn/components/navbar/custom_navBarSafePadding.dart';
import 'package:fl_valrn/components/widgets/custom_card.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/controllers/location_controller.dart';
import 'package:fl_valrn/controllers/market_controller.dart';
import 'package:fl_valrn/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketPage extends GetView<MarketController> {
  MarketPage({super.key});

  final locC = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomNavbarsafepadding(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan lokasi
                _buildLocationHeader(),

                const CustomSpacing(height: 25),

                // Search field
                CustomTextfield(
                  isNumber: false,
                  controller: controller.searchController,
                  label: 'Cari tanaman kamu..',
                ),

                const CustomSpacing(height: 20),

                // Banner card (testing)
                CustomCard(
                  title: "ngetes",
                  subtitle: "muncul kaga",
                  imageUrl:
                      "https://i.pinimg.com/736x/3a/ee/ee/3aeeee1d04b16f5ab613337aca0721e7.jpg",
                  isExtendable: false,
                  isEcommerce: true,
                  isDescription: false,
                  width: double.infinity,
                ),

                const CustomSpacing(height: 20),

                // Popular Categories Section
                _buildSectionHeader("Popular Categories"),
                const CustomSpacing(height: 12),
                _buildTrendingList(),

                const CustomSpacing(height: 20),

                // Mungkin kamu tertarik Section
                _buildSectionHeader("Mungkin kamu tertarik", showSeeAll: false),
                const CustomSpacing(height: 12),
                _buildProductList(),

                const CustomSpacing(height: 20),

                // Grid produk
                _buildProductGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk header lokasi
  Widget _buildLocationHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.pin_drop_sharp, color: Color(0xff2A9134), size: 40),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: locC.kecamatan.value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            CustomText(
              text: '${locC.kabupaten.value}, ${locC.provinsi.value}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  // Widget untuk section header
  Widget _buildSectionHeader(String title, {bool showSeeAll = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        if (showSeeAll)
          CustomText(
            text: "See all",
            style: const TextStyle(fontSize: 12, color: Color(0xFF2A9134)),
          ),
      ],
    );
  }

  // Widget untuk trending categories list
  Widget _buildTrendingList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: 220,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      return SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.trendingCard.length,
          itemBuilder: (context, index) {
            final item = controller.trendingCard[index];
            return CustomCard(
              title: item.title,
              subtitle: item.subtitle,
              imageUrl: item.imageUrl,
              isExtendable: false,
              isEcommerce: false,
              isDescription: false,
              height: 152,
              width: 120,
              isImageLeft: false,
            );
          },
        ),
      );
    });
  }

  // Widget untuk product horizontal list
  Widget _buildProductList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: 220,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      return SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.productCard.length,
          itemBuilder: (context, index) {
            final item = controller.productCard[index];
            return CustomCard(
              title: item.title,
              subtitle: item.subtitle,
              imageUrl: item.imageUrl,
              rate: item.rate,
              price: item.price,
              isExtendable: false,
              isEcommerce: true,
              isDescription: true,
              textSize: 20,
              height: 240,
              width: 260,
              isImageLeft: false,
              onTap: () => _navigateToProduct(item),
            );
          },
        ),
      );
    });
  }

  // Widget untuk product grid
  Widget _buildProductGrid() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.productCard.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          childAspectRatio: 180 / 244,
        ),
        itemBuilder: (context, index) {
          final item = controller.productCard[index];
          return CustomCard(
            title: item.title,
            subtitle: item.subtitle,
            imageUrl: item.imageUrl,
            rate: item.rate,
            price: item.price,
            isEcommerce: true,
            isDescription: true,
            height: 244,
            width: 184,
            isImageLeft: false,
            textSize: 14,
            onTap: () => _navigateToProduct(item),
          );
        },
      );
    });
  }

  // Helper method untuk navigasi
  void _navigateToProduct(dynamic productItem) {
    Get.to(() => ProductPage(), arguments: productItem);
  }
}
