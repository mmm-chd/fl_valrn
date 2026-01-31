import 'package:fl_valrn/components/navbar/custom_navBarSafePadding.dart';
import 'package:fl_valrn/components/widgets/custom_card.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/controllers/profile_controller.dart';
import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:fl_valrn/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({super.key});
  final userC = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBEBEB),
      body: SingleChildScrollView(
        child: CustomNavbarsafepadding(
          child: Column(
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

                  Obx(
                    () => controller.isMyProfile.value
                        ? const SizedBox.shrink()
                        : Positioned(
                            top: 32,
                            left: 16,
                            child: Container(
                              width: 36,
                              height: 36,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: Color(0xffEBEBEB).withOpacity(0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                iconSize: 36,
                                icon: const Icon(
                                  Icons.chevron_left_rounded,
                                  color: Color(0xff2A9134),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                  ),

                  // SETTINGS ICON
                  Positioned(
                    top: 40,
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
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1595152772835-219674b2a8a6?w=200',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const CustomSpacing(height: 84),
              // Name
              Obx(() {
                if (controller.isLoading.value) {
                  return CircularProgressIndicator();
                }
                final profile = controller.profile.value;
                return CustomText(
                  text: profile?.name ?? 'Loading...',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              }),
              const CustomSpacing(height: 6),
              // Name
              CustomText(
                text: userC.name.value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const CustomSpacing(height: 6),

              // Description
              Obx(() {
                final profile = controller.profile.value;
                return CustomText(
                  text: profile?.about ?? 'Halo, edit deskripsi anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 14,
                    height: 1.4,
                  ),
                );
              }),
              const CustomSpacing(height: 16),

              // Button Kirim Pesan + Menu
              Obx(
                () => controller.isMyProfile.value
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          children: [
                            // Button Kirim Pesan (ambil sebagian besar space)
                            Expanded(
                              flex: 5, // Proporsi button
                              child: ElevatedButton(
                                onPressed: () {
                                  // Action kirim pesan
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff2A9134),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  elevation: 2,
                                  shadowColor: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Kirim Pesan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Button Menu (3 dots) - ukuran fixed
                            Container(
                              height: 48, // Sama tinggi dengan button
                              width: 48, // Lebar fixed
                              decoration: BoxDecoration(
                                color: Color(0xFFEBEBEB), // Background putih
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Color(0xFFAFAFAF), // Outline hitam
                                  width: 1.5, // Ketebalan border
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  // Action menu
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.black87,
                                  size: 24,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ),
                          ],
                        ),
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
                    Obx(() {
                      final profile = controller.profile.value;
                      return CustomText(
                        text: profile?.about ?? 'Halo, edit deskripsi anda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      );
                    }),
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
                    Obx(() {
                      final profile = controller.profile.value;
                      return _buildInfoRow(
                        icon: Icons.camera_alt_outlined,
                        label: 'Instagram',
                        value: profile?.insta ?? '-',
                        valueColor: Colors.green,
                      );
                    }),
                    const SizedBox(height: 12),

                    // Telephone
                    Obx(() {
                      final profile = controller.profile.value;
                      return _buildInfoRow(
                        icon: Icons.phone_outlined,
                        label: 'Telephone',
                        value: profile?.phone ?? '-',
                        valueColor: Colors.green,
                      );
                    }),
                    const SizedBox(height: 12),

                    // Facebook
                    Obx(() {
                      final profile = controller.profile.value;
                      return _buildInfoRow(
                        icon: Icons.facebook_outlined,
                        label: 'Facebook',
                        value: profile?.facebook ?? '-',
                        valueColor: Colors.green,
                      );
                    }),
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

                        Obx(
                          () => controller.isMyProfile.value
                              ? const SizedBox.shrink()
                              : GestureDetector(
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
                        ),
                      ],
                    ),

                    // Grid Produk
                    Obx(() {
                      if (controller.products.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: CustomText(
                              text: 'Belum ada produk',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
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
                            imageUrl: item.imageUrl,
                            price: item.price.toString(),
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
    );
  }
}

Widget _buildInfoRow({
  required IconData icon,
  required String label,
  required String value,
  required Color valueColor,
}) {
  return Row(
    children: [
      Icon(icon, color: Colors.grey.shade400, size: 24),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ),
      ),
      CustomText(
        text: value,
        style: TextStyle(
          color: valueColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double rating;
  final String location;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFC107), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
