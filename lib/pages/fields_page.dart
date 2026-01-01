import 'package:fl_valrn/components/widgets/custom_card.dart';
import 'package:fl_valrn/components/widgets/custom_clipper.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/controllers/field_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldsPage extends GetView<FieldsController> {
  const FieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            ClipPath(
              clipper: CurvedHeaderClipper(),
              child: Container(
                height: 180,
                width: double.infinity,
                color: const Color(0xFF2A9134),
                child: SafeArea(
                  bottom: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomText(
                        text: "My Fields",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  CustomTextfield(
                    isNumber: false,
                    controller: controller.searchController,
                    label: 'Cari tanaman kamu..',
                  ),

                  const SizedBox(height: 20),

                  CustomText(
                    text: "Recently",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CustomSpacing(height: 12,),
                  Obx((){
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
                          itemCount: controller.recentCard.length,
                          itemBuilder: (context, index) {
                            return CustomCard(
                              title: controller.recentCard[index].title, 
                              subtitle: controller.recentCard[index].subtitle, 
                              imageUrl: controller.recentCard[index].imageUrl, 
                              isExtendable: false, isEcommerce: false, isDescription: true,
                              height: 216,
                              width: 172, isImageLeft: false,
                            );
                          },
                        ),
                      );
                  }),



                  const SizedBox(height: 20),

                  CustomText(
                    text: "Your Fields",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return Column(
                      children: controller.fieldsCard.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CustomCard(
                            title: item.title,
                            subtitle: item.subtitle,
                            imageUrl: item.imageUrl,
                            isExtendable: true,
                            isEcommerce: false,
                            isDescription: true,
                            height: 152,
                            width: 408,
                            isImageLeft: true,
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
