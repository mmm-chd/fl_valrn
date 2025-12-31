import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? price;
  final double? rate;
  final double? width;
  final double? height;
  final double? radius;
  final VoidCallback? onTap;
  final bool isExtendable;
  final bool isEcommerce;

  const CustomCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.price,
    this.rate,
    this.width,
    this.height,
    this.radius,
    this.onTap,
    required this.isExtendable,
    required this.isEcommerce,
  });

  

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius ?? 16);

    return SizedBox(
      width: width ?? 280,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE SECTION
              Stack(
                children: [
                  Image.network(
                    imageUrl,
                    height: height ?? 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  // EXTENDABLE → menu icon (kiri atas)
                  if (isExtendable)
                    const Positioned(
                      top: 8,
                      left: 8,
                      child: Icon(Icons.more_vert, color: Colors.white),
                    ),

                  // ECOMMERCE → price label (kanan atas)
                  if (isEcommerce && price != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          price!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // EXTENDABLE → arrow icon (kiri bawah)
                  if (isExtendable)
                    const Positioned(
                      bottom: 8,
                      left: 8,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),

              // CONTENT SECTION
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    // ECOMMERCE → rating
                    if (isEcommerce && rate != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rate!.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
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
Widget customCardPreview(BuildContext context) {
  return Material(
    color: Colors.grey.shade200,
    child: Center(
      child: CustomCard(
        title: 'Product Name',
        subtitle: 'Short description goes here',
        imageUrl: 'https://picsum.photos/400/300',
        price: 'Rp 25.000',
        rate: 4.6,
        isExtendable: true,
        isEcommerce: true,
      ),
    ),
  );
}