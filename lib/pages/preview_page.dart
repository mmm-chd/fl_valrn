import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String imagePath = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Image.file(
        File(imagePath),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}