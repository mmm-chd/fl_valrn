import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan background image
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 268,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Profile Picture - Positioned
                Positioned(
                  bottom: -70,  
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

            const CustomSpacing(height: 80),

            // Name
            CustomText(
              text: 'Mr. Farmer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            // Description
            const CustomText(
              text: 'Hello everyone, im just a farmer\nin kudus jln',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 14,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
            const SizedBox(height: 16),

            // Tentang Saya Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Tentang saya',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const CustomText(
                    text: 'Saya suka menanam dan memcari teman berbisnis jln',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      height: 1.5,
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),

                  // Instagram
                  _buildInfoRow(
                    icon: Icons.camera_alt_outlined,
                    label: 'Instagram',
                    value: 'PetaniKeren',
                    valueColor: Colors.green,
                  ),
                  const SizedBox(height: 12),

                  // Telephone
                  _buildInfoRow(
                    icon: Icons.phone_outlined,
                    label: 'Telephone',
                    value: '082136508987',
                    valueColor: Colors.green,
                  ),
                  const SizedBox(height: 12),

                  // Facebook
                  _buildInfoRow(
                    icon: Icons.facebook_outlined,
                    label: 'Facebook',
                    value: 'PetaniKeren69',
                    valueColor: Colors.green,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Produk saya',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),

                  // Grid Produk
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.78,
                        ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        imageUrl:
                            'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=400',
                        name: 'Bawang Merah',
                        rating: 4.5,
                        location: 'Kabupaten kudus, Jatira...',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
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
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ),
        Text(
          value,
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


