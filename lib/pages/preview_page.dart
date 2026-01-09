import 'dart:io';

import 'package:fl_valrn/controllers/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PreviewPage extends GetView<CameraPageController> {

  final String imagePath;
  
  const PreviewPage({super.key, required this.imagePath});

  

  @override
  Widget build(BuildContext context) {
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