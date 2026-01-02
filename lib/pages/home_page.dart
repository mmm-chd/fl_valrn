import 'package:fl_valrn/components/navbar/custom_navBarSafePadding.dart';
import 'package:fl_valrn/components/widgets/custom_card.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 40),
        child: SingleChildScrollView(
          child: CustomNavbarsafepadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Halo, {User}!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CustomSpacing(height: 4),
                        Row(
                          children: [
                            CustomText(
                              text: "Lokasi tembak kesini",
                              style: TextStyle(fontSize: 14),
                            ),
                            Icon(
                              Icons.pin_drop_sharp,
                              size: 20,
                              color: Color(0xFF2A9134),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications,
                      size: 36,
                      color: Color(0xFF2A9134),
                    ),
                  ],
                ),
                CustomSpacing(height: 20),

                CustomTextfield(
                  isNumber: false,
                  controller: controller.searchController,
                  label: 'Cari tanaman kamu..',
                ),
                CustomSpacing(height: 20),
                CustomCard(
                  title: "ngetes",
                  subtitle: "muncul kaga",
                  imageUrl:
                      "https://i.pinimg.com/736x/2f/de/99/2fde9942cfc7d25f34411c9ca1d8990f.jpg",
                  isExtendable: false,
                  isEcommerce: true,
                  isDescription: false,
                  width: double.infinity, // atau hapus sekalian
                ),

                CustomSpacing(height: 8),
                CustomText(
                  text: "Trending",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                CustomSpacing(height: 12),
                Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
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
                        return CustomCard(
                          title: controller.trendingCard[index].title,
                          subtitle: controller.trendingCard[index].subtitle,
                          imageUrl: controller.trendingCard[index].imageUrl,
                          isExtendable: false,
                          isEcommerce: false,
                          isDescription: true,
                          height: 180,
                          width: 144,
                          isImageLeft: false,
                        );
                      },
                    ),
                  );
                }),

                CustomSpacing(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "My Garden",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    CustomText(
                      text: "See More",
                      style: TextStyle(fontSize: 12, color: Color(0xFF2A9134)),
                    ),
                  ],
                ),
                CustomSpacing(height: 12),
                Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: 220,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.fieldsCard.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                          title: controller.fieldsCard[index].title,
                          subtitle: controller.fieldsCard[index].subtitle,
                          imageUrl: controller.fieldsCard[index].imageUrl,
                          isExtendable: false,
                          isEcommerce: false,
                          isDescription: true,
                          height: 184,
                          width: 128,
                          isImageLeft: false,
                        );
                      },
                    ),
                  );
                }),

                CustomSpacing(height: 25),
                CustomText(
                  text: "Rekomendasi Bacaan Spesial",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                CustomText(
                  text: "Artikel menarik yang sayang dilewatkan",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                CustomSpacing(height: 12),
                Obx(() {
                  return ListView.builder(
                    itemCount: controller.artikelCard.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CustomCard(
                        title: controller.artikelCard[index].title,
                        subtitle: controller.artikelCard[index].subtitle,
                        imageUrl: controller.artikelCard[index].imageUrl,
                        isExtendable: false,
                        isEcommerce: false,
                        isDescription:
                            controller.artikelCard[index].isDescription,
                        isImageLeft: controller.artikelCard[index].isImageLeft,
                        height: 208,
                        width: 408,
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
