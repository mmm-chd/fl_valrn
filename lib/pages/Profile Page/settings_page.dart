import 'package:fl_valrn/components/widgets/custom_formSection.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<ProfileController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    text: "Pengaturan",
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
              margin: EdgeInsets.all(20),
              padding: EdgeInsetsGeometry.all(16),
              border: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Akun & Profil", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),),
                  CustomSpacing(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 28,color: Colors.grey,),
                      CustomSpacing(width: 10,),
                      CustomText(text: "Akun", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size:18 ,)
                    ],
                  ),
                  CustomSpacing(height: 8,),
                  CustomText(text: "Preferensi", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),),
                  CustomSpacing(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 28,color: Colors.grey,),
                      CustomSpacing(width: 10,),
                      CustomText(text: "Bahasa", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size:18 ,)
                    ],
                  ),
                  CustomSpacing(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 28,color: Colors.grey,),
                      CustomSpacing(width: 10,),
                      CustomText(text: "Notifikasi", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size:18 ,)
                    ],
                  ),
                  CustomSpacing(height: 12,),
                  Divider(thickness: 1.5, color: Colors.grey,),
                  CustomSpacing(height: 12,),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 28,color: Colors.grey,),
                      CustomSpacing(width: 10,),
                      CustomText(text: "Saved Product", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size:18 ,)
                    ],
                  ),
                  CustomSpacing(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 28,color: Colors.grey,),
                      CustomSpacing(width: 10,),
                      CustomText(text: "FnQ", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size:18 ,)
                    ],
                  ),
                ],
              )
            ),
        
            CustomFormsection(
              margin: EdgeInsets.only(right: 20, left: 20),
              padding: EdgeInsetsGeometry.all(16),
              border: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Mengenai Aplikasi", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),),
                  CustomSpacing(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 28,color: Colors.grey,),
                      CustomSpacing(width: 10,),
                      CustomText(text: "Tentang Aplikasi", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size:18 ,)
                    ],
                  ),
                  CustomSpacing(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 28,color: Colors.grey,),
                      CustomSpacing(width: 10,),
                      CustomText(text: "Aturan Privasi", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size:18 ,)
                    ],
                  ),
                  
                ],
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
              width: 150,
              margin: EdgeInsets.only(top: 25),
              child: ElevatedButton(onPressed: 
              () async{
                await controller.logout();
                Get.offAllNamed(AppRoutes.authPage);
              }, child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red,),
                  CustomSpacing(width: 8,),
                  Expanded(child: CustomText(text: "Log Out", style: TextStyle(
                    color: Colors.red
                  ),) )
                ],
              )),
      ),
    );
  }
}