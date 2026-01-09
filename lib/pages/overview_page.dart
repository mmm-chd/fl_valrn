import 'package:fl_valrn/components/widgets/custom_bulletlist.dart';
import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/components/widgets/custom_rowtext.dart';
import 'package:fl_valrn/components/widgets/custom_section_title.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_tabBar.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/controllers/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OverviewController());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // =========================
          // IMAGE GALLERY (tanpa AppBar)
          // =========================
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250,
              child: Stack(
                children: [
                  // Main large image
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    right: 120,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: const DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/400'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Three small images on the right
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: 120,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image: const DecorationImage(
                                image: NetworkImage('https://via.placeholder.com/120'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image: const DecorationImage(
                                image: NetworkImage('https://via.placeholder.com/120'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image: const DecorationImage(
                                image: NetworkImage('https://via.placeholder.com/120'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Back button
                  Positioned(
                    top: 40,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =========================
          // CONTENT SECTION
          // =========================
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plant name and scientific name
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
                              color: Color(0xff52A068),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab Bar
                  _tabBar(controller),
                  
                  // Tab Content
                  Obx(
                    () => controller.currentTabIndex.value == 0
                        ? _diseaseTab(controller)
                        : _detectionTab(controller),
                  ),
                ],
              ),
            ),
          ),

          // Fill remaining space
          const SliverFillRemaining(
            hasScrollBody: false,
            child: CustomSpacing(),
          ),
        ],
      ),
      
      // Save button - sticky at bottom
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
            onPressed: () => controller.saveToJournal(),
          ),
        ),
      ),
    );
  }

  // =========================
  // TAB BAR
  // =========================
  Widget _tabBar(OverviewController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Center(
        child: Container(
          width: 280,
          height: 45,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTabbar(
                  text: 'Penyakit',
                  tabIndex: 0,
                  currentIndex: controller.currentTabIndex,
                  onTap: (i) => controller.selectTab(i),
                ),
              ),
              const CustomSpacing(width: 4),
              Expanded(
                child: CustomTabbar(
                  text: 'Deteksi',
                  tabIndex: 1,
                  currentIndex: controller.currentTabIndex,
                  onTap: (i) => controller.selectTab(i),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // DISEASE TAB (PENYAKIT)
  // =========================
  Widget _diseaseTab(OverviewController controller) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Disease title with orange background
          Obx(
            () => SectionTitle(
              title: 'Tanaman Kamu Terkena Penyakit!\n${controller.diseaseTitle.value}',
              color: const Color(0xffFFF3E0),
            ),
          ),
          const CustomSpacing(height: 20),

          // Description Title
          const CustomText(
            text: 'Penjelasan Penyakit',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff333333),
            ),
          ),
          const CustomSpacing(height: 12),
          
          // Description in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => CustomText(
                text: controller.diseaseDescription.value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xff666666),
                  height: 1.6,
                ),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          // Symptoms Title
          const CustomText(
            text: 'Gejala',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff333333),
            ),
          ),
          const CustomSpacing(height: 12),
          
          // Symptoms in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => Column(
                children: controller.symptoms
                    .map((symptom) => BulletListItem(text: symptom))
                    .toList(),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          // Impact Title
          const CustomText(
            text: 'Dampak',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff333333),
            ),
          ),
          const CustomSpacing(height: 12),
          
          // Impact in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => Column(
                children: controller.impact
                    .map((item) => BulletListItem(text: item))
                    .toList(),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          // Prevention Title
          const CustomText(
            text: 'Penanggunalangan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff333333),
            ),
          ),
          const CustomSpacing(height: 12),
          
          // Prevention in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => Column(
                children: controller.prevention
                    .map((item) => BulletListItem(text: item))
                    .toList(),
              ),
            ),
          ),
          const CustomSpacing(height: 40),
        ],
      ),
    );
  }

  // =========================
  // DETECTION TAB (DETEKSI & HABITAT)
  // =========================
  Widget _detectionTab(OverviewController controller) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nutrition title
          const SectionTitle(
            title: 'Distribusi & Habitat',
            color: Color(0xffE8F5E9),
          ),
          const CustomSpacing(height: 16),

          // Nutrition data in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => Column(
                children: controller.nutritionData.entries
                    .map((entry) => InfoRow(
                          leftText: entry.key,
                          rightText: entry.value,
                        ))
                    .toList(),
              ),
            ),
          ),
          const CustomSpacing(height: 20),

          // Description in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => CustomText(
                text: controller.descriptionText.value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xff666666),
                  height: 1.6,
                ),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          // Habitat Title
          Obx(
            () => CustomText(
              text: controller.habitatTitle.value,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xff333333),
              ),
            ),
          ),
          const CustomSpacing(height: 12),
          
          // Habitat text in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => CustomText(
                text: controller.habitatText.value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xff666666),
                  height: 1.6,
                ),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          // Advantages Title
          const CustomText(
            text: 'Keunggulan (SBG Obat)',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff333333),
            ),
          ),
          const CustomSpacing(height: 12),
          
          // Advantages in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => Column(
                children: controller.advantages
                    .map((item) => BulletListItem(text: item))
                    .toList(),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          // Disadvantages Title
          const CustomText(
            text: 'Kekurangan (SBG Obat)',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff333333),
            ),
          ),
          const CustomSpacing(height: 12),
          
          // Disadvantages in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => Column(
                children: controller.disadvantages
                    .map((item) => BulletListItem(text: item))
                    .toList(),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          // Cultivation Title
          const CustomText(
            text: 'Cara Budidaya',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff333333),
            ),
          ),
          const CustomSpacing(height: 12),
          
          // Cultivation in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => Column(
                children: controller.cultivation
                    .map((item) => BulletListItem(text: item))
                    .toList(),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          // Fun Fact Title
          const CustomText(
            text: 'Keunikan Produk / Tanaman',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff333333),
            ),
          ),
          const CustomSpacing(height: 12),
          
          // Fun Fact in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => CustomText(
                text: controller.funFact.value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xff666666),
                  height: 1.6,
                ),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          // Fun Fact with icon in box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xffFFF9E6),
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: Color(0xffFFA726),
                  size: 24,
                ),
                const CustomSpacing(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Fungsi Obat',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff333333),
                        ),
                      ),
                      const CustomSpacing(height: 8),
                      Obx(
                        () => CustomText(
                          text: controller.funFact.value,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff666666),
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomSpacing(height: 40),
        ],
      ),
    );
  }
}