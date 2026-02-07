import 'package:fl_valrn/components/navbar/custom_navBarSafePadding.dart';
import 'package:fl_valrn/components/widgets/custom_card.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/controllers/profile_controller.dart';
import 'package:fl_valrn/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBEBEB),
      body: RefreshIndicator(
        onRefresh: controller.refreshProfile,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: CustomNavbarsafepadding(
            child: Obx(() {
              // Loading State
              if (controller.isLoading.value) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final profile = controller.userSession.value;

              return Column(
                children: [
                  // Header dengan background image
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 260,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // SETTINGS ICON
                      Positioned(
                        top: 50,
                        right: 16,
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: Color(0xffEBEBEB).withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(blurRadius: 6, color: Colors.black26),
                            ],
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            iconSize: 28,
                            icon: const Icon(
                              Icons.settings_rounded,
                              color: Color(0xff2A9134),
                            ),
                            onPressed: () {
                              Get.toNamed(AppRoutes.settingsPage);
                            },
                          ),
                        ),
                      ),

                      // Profile Picture - Positioned
                      Positioned(
                        bottom: -75,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Color(0xff2A9134),
                              child: Text(
                                profile.name.isNotEmpty
                                    ? profile.name[0].toUpperCase()
                                    : '?',
                                style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const CustomSpacing(height: 84),

                  // Name
                  CustomText(
                    text: profile.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const CustomSpacing(height: 6),

                  // Email
                  CustomText(
                    text: profile.email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),

                  const CustomSpacing(height: 20),

                  Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
                  const CustomSpacing(height: 16),

                  // Tentang Saya Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Tentang saya',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          text:
                              profile.description ??
                              'Belum ada deskripsi. Tambahkan deskripsi Anda di pengaturan.',
                          style: TextStyle(
                            color: profile.description.isNull
                                ? Color(0xFF424242)
                                : Color(0xFF9E9E9E),
                            fontSize: 14,
                            height: 1.4,
                            fontStyle: profile.description.isNull
                                ? FontStyle.italic
                                : FontStyle.normal,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
                  const SizedBox(height: 12),

                  // Informasi Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Informasi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Instagram
                        Obx(
                          () => _buildInfoRow(
                            isExpanded: controller.isExpandInstagram.value,
                            onTap: controller.clickExpandInstagram,
                            icon: Icons.camera_alt_outlined,
                            label: 'Instagram',
                            value: profile.instagram ?? '-',
                            valueColor: (profile.instagram?.isNotEmpty ?? false)
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Telephone
                        Obx(
                          () => _buildInfoRow(
                            isExpanded: controller.isExpandPhone.value,
                            onTap: controller.clickExpandPhone,
                            icon: Icons.phone_outlined,
                            label: 'Telephone',
                            value: profile.phone ?? '-',
                            valueColor: (profile.phone?.isNotEmpty ?? false)
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Facebook
                        Obx(
                          () => _buildInfoRow(
                            isExpanded: controller.isExpandFacebook.value,
                            onTap: controller.clickExpandFacebook,
                            icon: Icons.facebook_outlined,
                            label: 'Facebook',
                            value: profile.facebook ?? '',
                            valueColor: (profile.facebook?.isNotEmpty ?? false)
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const CustomSpacing(height: 16),

                  Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
                  const CustomSpacing(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CustomText(
                              text: 'Produk saya',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.myProductPage);
                              },
                              child: CustomText(
                                text: 'Edit Produk',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                  fontFamily:
                                      GoogleFonts.montserrat().fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Grid Produk
                        controller.products.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 64.0,
                                ),
                                child: Center(
                                  child: CustomText(
                                    text: 'Belum ada produk',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.78,
                                    ),
                                itemCount: controller.products.length,
                                itemBuilder: (context, index) {
                                  final item = controller.products[index];
                                  return CustomCard(
                                    title: item.title,
                                    subtitle: item.subtitle,
                                    imageUrl:
                                        item.imageUrl ??
                                        "https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg",
                                    price: item.price.toString(),
                                    isEcommerce: true,
                                    isDescription: true,
                                    onTap: () {
                                      Get.to(
                                        () => ProductPage(),
                                        arguments: item,
                                      );
                                    },
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoRow({
  required IconData icon,
  required String label,
  required String value,
  required Color valueColor,
  required bool isExpanded,
  required VoidCallback onTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 1,
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade400, size: 24),
            const CustomSpacing(width: 12),
            CustomText(
              text: label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
          ],
        ),
      ),
      Flexible(
        child: GestureDetector(
          onTap: onTap,
          child: CustomText(
            text: value,
            maxLines: isExpanded ? null : 1,
            style: TextStyle(
              color: valueColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ],
  );
}
