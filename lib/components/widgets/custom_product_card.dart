import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:flutter/material.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key, required this.images, required this.currentIndex, required this.onPageChanged, this.onBack, this.onShare, this.onMore, this.onBookmark, required this.title, required this.subtitle, this.trailing});
  final List<String> images;
  final int currentIndex;
  final Function(int)onPageChanged;

  final VoidCallback? onBack;
  final VoidCallback? onShare;
  final VoidCallback? onMore;
  final VoidCallback? onBookmark;

  final String title;
  final String subtitle;
  final Widget? trailing;

@override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // IMAGE CAROUSEL
            SizedBox(
              height: 320,
              width: double.infinity,
              child: PageView.builder(
                itemCount: images.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            // TOP OVERLAY ICONS
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  _circleIcon(Icons.arrow_back, onBack,),
                  const Spacer(),
                  _circleIcon(Icons.share, onShare),
                  const SizedBox(width: 8),
                  _circleIcon(Icons.more_vert, onMore),
                ],
              ),
            ),

            // INDICATOR
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${currentIndex + 1}/${images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),

        // BOTTOM LABEL
        Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0xFF2A9134),
          child: Row(
            children: [ Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              const Spacer(),
              _circleIcon(Icons.handshake, onBack,),
              CustomSpacing(width: 20,),
              _circleIcon(Icons.bookmark_add, onBookmark,),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ],
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.9),
        ),
        child: Icon(icon, size: 24, color: Color(0xff2A9134)),
      ),
    );
  }
}