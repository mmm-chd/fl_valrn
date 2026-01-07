import 'package:fl_valrn/controllers/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PreviewPage extends GetView<CameraController> {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ngetes muncul kaga"),),
      body: Obx((){
        final image= controller.image.value;
        if (image == null) {
          return const Center(child: Text("gada foto"),);
        }
        return Image.file(image, fit: BoxFit.cover);
      }),
    );
  }
}