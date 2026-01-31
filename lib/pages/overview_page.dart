import 'dart:io';
import 'package:fl_valrn/components/widgets/custom_bottomSheetFix.dart';
import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/components/widgets/custom_detection_tab.dart';
import 'package:fl_valrn/components/widgets/custom_disease_tab.dart';
import 'package:fl_valrn/components/widgets/custom_formSection.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_tabBar.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OverviewController controller = Get.find();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Obx(() {
              final imageCount = controller.images.length;

              if (imageCount == 0) {
                return SizedBox(
                  height: 250,
                  child: Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image, size: 80, color: Colors.grey),
                    ),
                  ),
                );
              }

              Widget imageWidget;

              if (imageCount == 1) {
                imageWidget = Image.file(
                  File(controller.images[0]),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: Colors.grey[400]),
                );
              } else if (imageCount == 2) {
                imageWidget = Row(
                  children: [
                    Expanded(
                      child: Image.file(
                        File(controller.images[0]),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: Colors.grey[400]),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Image.file(
                        File(controller.images[1]),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: Colors.grey[400]),
                      ),
                    ),
                  ],
                );
              } else {
                imageWidget = Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.file(
                        File(controller.images[0]),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: Colors.grey[400]),
                      ),
                    ),
                    const SizedBox(width: 2),
                    SizedBox(
                      width: 120,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.file(
                              File(controller.images[1]),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  Container(color: Colors.grey[400]),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Expanded(
                            child: Image.file(
                              File(controller.images[2]),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  Container(color: Colors.grey[400]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    Positioned.fill(child: imageWidget),
                    _buildBackButton(),
                  ],
                ),
              );
            }),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Plant name
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => CustomText(
                            text: controller.plantName.value,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff333333),
                            ),
                          ),
                        ),
                        const CustomSpacing(height: 4),
                        Obx(
                          () => CustomText(
                            text: controller.scientificName.value,
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff2A9134),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 1.2,
                    color: Color(0xffDCDCDC),
                  ),

                  _tabBar(controller),

                  Obx(
                    () => controller.currentTabIndex.value == 0
                        ? DiseaseTab(controller: controller)
                        : DetectionTab(controller: controller),
                  ),
                ],
              ),
            ),
          ),

          const SliverFillRemaining(
            hasScrollBody: false,
            child: CustomSpacing(),
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: CustomButton(
            text: 'Save to my journal',
            backgroundColor: const Color(0xff52A068),
            foregroundColor: Colors.white,
            onPressed: () {
              CustomBottomsheetfix.show(
                context, 
                onDismissed: () {
                  print('Bottomsheet dismissed');
                },
                children: [
                  const CustomText(
                    text: "Add to MyFields",
                    style: TextStyle(
                      color: PColor.primGreen,
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                    ),),
                  CustomSpacing(height: 8,),
                  const CustomText(
                    text: 'Pilih opsi untuk menambahkan field ke daftar kamu atau membuat field baru.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const CustomSpacing(height: 16),
                  InkWell(
                    onTap: (){

                    },
                    child: CustomFormsection(
                      border: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                        child: InkWell(
                          onTap: (){
                    
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: PColor.primGreen.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.home, size: 22,)),
                              CustomSpacing( width: 8,),
                    
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Perbarui Fields",
                                    style: TextStyle(
                                      color: PColor.primGreen,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),),
                                  CustomText(
                                    text: "Sesuaikan dan perbarui data field",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),),
                                    
                                
                                ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  ),

                    const CustomSpacing(height: 16),
                  InkWell(
                    child: CustomFormsection(
                      border: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                        child: InkWell(
                          onTap: (){
                      
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: PColor.primGreen.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add, size: 22,)),
                              CustomSpacing( width: 8,),
                    
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Buat Fields Baru",
                                    style: TextStyle(
                                      color: PColor.primGreen,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),),
                                  CustomText(
                                    text: "Buat field baru untuk pengelolaan",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),),
                                    
                                
                                ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  ),

                  
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  static Widget _buildBackButton() {
    return SafeArea(
      child: Positioned(
        top: 8,
        left: 16,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xff52A068),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBar(OverviewController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Center(
        child: Container(
          width: 280,
          height: 45,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xffD0EAD4),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTabbar(
                  text: 'Penyakit',
                  tabIndex: 0,
                  currentIndex: controller.currentTabIndex,
                  onTap: controller.selectTab,
                ),
              ),
              const CustomSpacing(width: 4),
              Expanded(
                child: CustomTabbar(
                  text: 'Deteksi',
                  tabIndex: 1,
                  currentIndex: controller.currentTabIndex,
                  onTap: controller.selectTab,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
