import 'package:flutter/material.dart';

class CustomMyProductCard extends StatelessWidget {
  const CustomMyProductCard({super.key, required this.imageUrl, required this.title, required this.category, required this.price, this.onEdit});
  final String imageUrl;
  final String title;
  final String category;
  final String price;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12)
                ),
                child: Image.network(
                  imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  
              ))
            ],
          )
        ],
      ),
    );
  }
}