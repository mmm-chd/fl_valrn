import 'package:fl_valrn/components/widgets/custom_formSection.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyproductPage extends GetView<ProductController> {
  const MyproductPage({super.key});

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
                  margin: const EdgeInsets.only(top: 30, left: 8, right: 8),
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
                            size: 25,
                            color: PColor.primGreen,
                          ),
                        ),
                      ),
                      
                      CustomText(
                        text: "Produk Saya",
                        style: TextStyle(
                          color: PColor.primGreen,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
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

                CustomTextfield(
                  isNumber: false, 
                  controller: controller.searchProduct,
                  variant: TextFieldVariant.underline,
                ),

                Row(
                  children: [
                    CustomText(text: "Produk Kamu"),
                    Spacer(),
                    InkWell(child: CustomText(text: "+ Tambah Produk"))
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}