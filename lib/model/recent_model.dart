import 'package:flutter/widgets.dart';

class RecentItems {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  RecentItems({required this.title, required this.subtitle,this.onTap,required this.imageUrl});
}