import 'package:fl_valrn/components/widgets/custom_text.dart';
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
  final double? textSize;
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
    this.textSize,
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
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff2A9134),
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      size: 24,
                      color: Colors.white,
                    ),
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
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: textSize ?? 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              if (isEcommerce && rate != null) ...[
                const SizedBox(width: 8),
                const Icon(Icons.star, size: 16, color: Colors.black),
                const SizedBox(width: 4),
                Text(
                  rate!.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ],
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final bool imageOnly = !isDescription;

    return Stack(
      children: [
        Positioned.fill(child: Image.network(imageUrl, fit: BoxFit.cover)),

        // PRICE BADGE (ECOMMERCE)
        if (isEcommerce && price != null)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(175, 109, 109, 109),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomText(
                text: price!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        // IMAGE ONLY TEXT OVERLAY
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
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
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
        SizedBox(width: 120, height: double.infinity, child: _buildImage()),

        // CONTENT (RIGHT)
        Expanded(child: _buildContent()),
      ],
    );
  }
}
