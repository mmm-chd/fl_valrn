import 'package:fl_valrn/components/widgets/custom_card.dart';
import 'package:fl_valrn/components/widgets/custom_product_card.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/controllers/market_controller.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductPage extends GetView<MarketController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments as ProductItem;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return CustomProductCard(
                images: [item.imageUrl],
                currentIndex: controller.currentIndex.value,
                onPageChanged: controller.onPageChanged,
                title: item.title,
                // Format harga menggunakan controller
                subtitle: controller.formatPrice(item.price),
                onBack: () {
                  Get.back();
                },
                onBookmark: () {},
                onMore: () {},
                onShare: () {},
              );
            }),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Kirim Pesan Ke Penjual",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const CustomSpacing(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextfield(
                          isNumber: false,
                          controller: controller.chatController,
                          hint: "Apa ini masih ada?",
                          label: "Apa ini masih ada?",
                          variant: TextFieldVariant.underline,
                        ),
                      ),
                      const CustomSpacing(height: 10, width: 10),
                      Obx(() {
                        return SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: controller.isSendingMessage.value
                                ? null
                                : () => controller.sendWhatsAppMessage(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              disabledBackgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              elevation: 0,
                            ),
                            child: controller.isSendingMessage.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/waIcon.svg",
                                        color: Colors.white,
                                      ),
                                      const CustomSpacing(width: 8),
                                      const CustomText(
                                        text: "Kirim",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Deskripsi",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomText(
                    text: item.desc,
                    maxLines: 3,
                    style: TextStyle(fontSize: 14),
                  ),
                  const CustomSpacing(height: 10),
                  Divider(thickness: 2, color: Colors.grey[300]),
                  const CustomSpacing(height: 10),
                  Row(
                    children: [
                      CustomText(
                        text: "Informasi Penjual",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      CustomText(
                        text: "Detail penjual",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff2A9134),
                        ),
                      ),
                    ],
                  ),
                  CustomSpacing(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.person, size: 44),
                      CustomSpacing(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: item.user!.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          CustomText(
                            text: item.user!.email,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const CustomSpacing(height: 10),
                  Divider(thickness: 2, color: Colors.grey[300]),
                  const CustomSpacing(height: 10),
                ],
              ),
            ),
            const CustomSpacing(height: 10),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: const Color.fromARGB(229, 226, 220, 220),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomText(
                      text: "Mungkin Anda Tertarik",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: const Color.fromARGB(229, 226, 220, 220),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
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
                    price: controller.formatPrice(item.price),
                    isEcommerce: true,
                    isDescription: true,
                    height: 244,
                    width: 184,
                    isImageLeft: false,
                    textSize: 14,
                    onTap: () {
                      Get.offNamed(
                        AppRoutes.productPage,
                        arguments: controller.productCard[index],
                        preventDuplicates: false,
                      );
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
