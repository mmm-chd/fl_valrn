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
  final bool isDescription;
  final bool isImageLeft;

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
    this.isExtendable = false,
    this.isEcommerce = false,
    this.isDescription = false,
    this.isImageLeft = false,
  });

  

@override
Widget build(BuildContext context) {
  final borderRadius = BorderRadius.circular(radius ?? 16);
  final bool imageOnly = !isDescription;

  return SizedBox(
    width: width ?? double.infinity,
    height: imageOnly ? 160 : height,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            imageOnly
                ? _buildImage()
                : isImageLeft
                    ? _buildImageLeftLayout()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 100, child: _buildImage()),
                          _buildContent(),
                        ],
                      ),

            if (isExtendable) ...[
              // TITIK 3 - KANAN ATAS
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.more_vert,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
              ),

              // PANAH - KANAN BAWAH
              Positioned(
                bottom: 8,
                right: 8,
                child: Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

Widget _buildContent() {
  return Padding(
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
          maxLines: 2, // batasi jumlah baris
          overflow: TextOverflow.ellipsis, // otomatis "...”
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        if (isEcommerce && rate != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(rate!.toStringAsFixed(1)),
            ],
          ),
        ],
      ],
    ),
  );
}
Widget _buildImage() {
  final bool imageOnly = !isDescription;

  return Stack(
    children: [
      Positioned.fill(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),

      if (imageOnly)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black54,
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}
Widget _buildImageLeftLayout() {
  return Row(
    children: [
      // IMAGE (LEFT)
      SizedBox(
        width: 120,
        height: double.infinity,
        child: _buildImage(),
      ),

      // CONTENT (RIGHT)
      Expanded(
        child: _buildContent(),
      ),
    ],
  );
}
}

