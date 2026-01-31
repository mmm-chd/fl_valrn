// lib/pages/market_page.dart

import 'package:fl_valrn/components/widgets/custom_card.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/configs/constant_api.dart';
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
      body: RefreshIndicator(
        onRefresh: controller.refreshProducts,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location Header
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pin_drop_sharp,
                            color: Color(0xff2A9134),
                            size: 40,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: locC.kecamatan.value,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                CustomText(
                                  text:
                                      '${locC.kabupaten.value}, ${locC.provinsi.value}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomSpacing(height: 25),

                      // Search Field
                      CustomTextfield(
                        isNumber: false,
                        controller: controller.searchController,
                        label: 'Cari tanaman kamu..',
                      ),
                    ],
                  ),
                ),

                // Products Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Products Grid
                      Obx(() {
                        // Loading State
                        if (controller.isLoading.value) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        // Error State
                        if (controller.hasError.value) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Colors.red,
                                  ),
                                  SizedBox(height: 16),
                                  CustomText(
                                    text: 'Gagal memuat produk',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  CustomText(
                                    text: controller.errorMessage.value,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: controller.fetchProducts,
                                    icon: Icon(Icons.refresh),
                                    label: Text('Coba Lagi'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2A9134),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        // Empty State
                        if (controller.filteredProducts.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16),
                                  CustomText(
                                    text:
                                        controller.searchController.text.isEmpty
                                        ? 'Belum ada produk tersedia'
                                        : 'Tidak ada produk yang ditemukan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        // Products Grid
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.filteredProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 8,
                                childAspectRatio: 180 / 244,
                              ),
                          itemBuilder: (context, index) {
                            final item = controller.filteredProducts[index];
                            return CustomCard(
                              title: item.title,
                              subtitle: item.subtitle,
                              imageUrl:
                                  item.imageUrl ??
                                  "https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg",
                              price: controller.formatPrice(item.price),
                              isEcommerce: true,
                              isDescription: true,
                              onTap: () {
                                Get.to(() => ProductPage(), arguments: item);
                              },
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
