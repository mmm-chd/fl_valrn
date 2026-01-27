import 'dart:io';
import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/components/widgets/custom_formSection.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/addProduct_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends GetView<AddproductController> {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2)
          ),
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 56,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: Get.back,
                          icon: Icon(
                            Icons.arrow_back,
                            size: 22,
                            color: PColor.primGreen,
                          ),
                        ),
                      ),
                      
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Tambah Produk",
                          style: TextStyle(
                            color: PColor.primGreen,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                CustomFormsection(
                  backgroundColor: Colors.amber,
                  child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.notifications, size: 24, color: Colors.white,),
                      CustomSpacing(width: 8,),
                      CustomText(text: "Ini kata mikel kasi notif")
                    ],
                  ),
                )),
            
                CustomFormsection(
                  child: Container(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Foto Produk", style: TextStyle(
                        fontSize: 20,
                      ),),
                      Obx(
                        ()=> Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            ...List.generate(
                              controller.images.length, 
                              (index)=> _ImageThumbnail(
                                file: controller.images[index],
                                onRemove: ()=> controller.removeImage(index)
                              ),
                            ),
                            _AddImageButton(
                              onTap: controller.pickImage
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                )),
                CustomFormsection(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Nama Produk",
                              style: TextStyle(
                                fontSize: 16
                              ),),
                            Spacer(),
                            CustomText(text: "0/225", style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              
                            ),)
                          ],
                        ),
                        CustomTextfield(
                          isNumber: false, 
                          controller: controller.productNamec,
                          label: "Masukkan Nama Produk",
                           variant: TextFieldVariant.underline,),
                      ],
                    ),
                )),
                CustomFormsection(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Deskripsi Produk",
                              style: TextStyle(
                                fontSize: 16
                              ),),
                            Spacer(),
                            CustomText(text: "0/3000", style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16
                            ),)
                          ],
                        ),
                        CustomTextfield(
                          isNumber: false, 
                          controller: controller.productNamec,
                          label: "Masukkan Deskripsi",
                          variant: TextFieldVariant.underline,),
                      ],
                    ),
                )),
                CustomFormsection(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.sort, size: 24, color: Colors.grey,),
                        CustomSpacing(width: 5,),
                        CustomText(
                          text: "Kategori",
                          style: TextStyle(
                            fontSize: 18
                          ),),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down_sharp, size: 24, color: Colors.grey,)
                      ],
                    ),
                )),
                CustomFormsection(child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.discount, size: 24, color: Colors.grey,),
                        CustomSpacing(width: 8,),
                        CustomText(text: "Harga Produk", style: TextStyle(
                          fontSize: 16,
                        ),),
                      ],
                    ),
                    CustomTextfield(
                      isNumber: false, 
                      controller: controller.productNamec,
                      label: "Masukkan Harga",
                      variant: TextFieldVariant.underline,)
                  ],
                )),
                // CustomFormsection(
                //   child: Container(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         CustomText(
                //           text: "Stok",
                //           style: TextStyle(
                //             fontSize: 16
                //           ),),
                //         CustomTextfield(
                //           isNumber: false, 
                //           controller: controller.productNamec,
                //           label: "Masukkan Stok Produk",),
                //       ],
                //     ),
                // )),
                CustomFormsection(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Lokasi",
                          style: TextStyle(
                            fontSize: 16
                          ),),
                        Row(
                          children: [
                            CustomText(text: "ini alamat", style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16
                            ),),
                            Spacer(),
                            InkWell(
                              onTap: (){},
                              child: CustomText(text: "Edit" ,style: TextStyle(
                                color: PColor.primGreen
                              ),),
                            )
                          ],
                        )
                      ],
                    ),
                )),

                CustomSpacing(
                  height: 20,
                ),

                CustomButton(text: "Buat Dagangan",
                foregroundColor: Colors.white,
                backgroundColor: PColor.primGreen,
                onPressed: (){},)
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  final XFile file;
  final VoidCallback onRemove;
  const _ImageThumbnail({super.key, required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(file.path),
            width: 72,
            height: 72,
            fit:  BoxFit.cover,
          ),
        ),

        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54
              ),
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.white,
              ),
            ),
        ))
      ],
    );
  }
}

class _AddImageButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddImageButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: CustomPaint(
        painter: _DashedBorderPainter(color: PColor.primGreen),
        child: SizedBox(
          height: 72,
          width: 72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: PColor.primGreen),
              const CustomSpacing(height: 4),
              CustomText(
                text: "Tambah\nFoto",
                style: TextStyle(
                  fontSize: 10,
                  color: PColor.primGreen,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tambahkan class ini di bawah _AddImageButton
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  
  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12),
      ));

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final startPoint = metric.getTangentForOffset(distance);
        final endPoint = metric.getTangentForOffset(distance + dashWidth);
        if (startPoint != null && endPoint != null) {
          canvas.drawLine(startPoint.position, endPoint.position, paint);
        }
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}