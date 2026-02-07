import 'dart:io';

import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewHeader extends StatelessWidget {
  final OverviewController controller;

  const OverviewHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        return SizedBox(
          height: 250,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // IMAGE
              _buildImage(),

              // BACK BUTTON (overlay aman)
              Positioned(
                top: 16,
                left: 20,
                child: SafeArea(child: _buildBackButton()),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildImage() {
    return Image.file(File(controller.images.first), fit: BoxFit.cover);
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: PColor.primGreen,
          size: 20,
        ),
      ),
    );
  }
}
