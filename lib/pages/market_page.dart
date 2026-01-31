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
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ===== HEADER LOKASI =====
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

            /// ===== SEARCH =====
            CustomTextfield(
              isNumber: false,
              controller: controller.searchController,
              label: 'Cari tanaman kamu..',
            ),

            CustomSpacing(height: 20),

            /// ===== BANNER =====
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

            CustomSpacing(height: 20),

            /// ===== POPULAR =====
            Row(
              children: const [
                CustomText(
                  text: "Popular Categories",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Spacer(),
                CustomText(
                  text: "See all",
                  style: TextStyle(color: Color(0xFF2A9134)),
                ),
              ],
            ),
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

            CustomSpacing(height: 12),

            SizedBox(
              height: 220,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.trendingCard.length,
                  itemBuilder: (context, index) {
                    final item = controller.trendingCard[index];
                    return CustomCard(
                      title: item.title,
                      subtitle: item.subtitle,
                      imageUrl: item.imageUrl,
                      height: 152,
                      width: 120,
                      isImageLeft: false,
                    );
                  },
                );
              }),
            ),

            CustomSpacing(height: 20),

            /// ===== GRID PRODUK =====
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.productCard.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                    price: item.price.toString(),
                    isEcommerce: true,
                    isDescription: true,
                    onTap: (){
                      Get.to(
                        ()=> ProductPage(),
                        arguments: item,
                      );
                    },
                  );
                },
              );
            }),
          ],
        )
        ),
      ),
    );
  }
}
