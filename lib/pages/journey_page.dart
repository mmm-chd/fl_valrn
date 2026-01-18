import 'package:fl_valrn/components/widgets/custom_dateTimeline.dart';
import 'package:fl_valrn/components/widgets/custom_journeyCard.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/journey_controller.dart';
import 'package:fl_valrn/model/fields_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JourneyPage extends GetView<JourneyController> {
  const JourneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FieldsItem field = Get.arguments;
    final List<PlantItem> plants = field.plants;

    return Scaffold(
      body: Column(
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
                      size: 25,
                      color: PColor.primGreen,
                    ),
                  ),
                ),
                
                CustomText(
                  text: "Journey",
                  style: TextStyle(
                    color: PColor.primGreen,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      
          Obx(() { 
            return  SizedBox( 
                height: 100, 
                child: CustomMonthSelector( 
                  selectedMonth: controller.selectedMonth.value, 
                  onChanged: controller.changeMonth, 
                ),); 
          }),
      
          Expanded(
            child: Obx((){
      
              final grouped = controller.groupedByDate;
              if (grouped.isEmpty) {
                return const Center(
                  child:  Text("Tidak ada data di bulan ini"),
                );
              }
      
              return ListView(
              padding: const EdgeInsets.all(16),
              children:grouped.entries.map((entry){
                final date= entry.key;
                final items= entry.value;
      
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CustomText(text: DateFormat('dd/MM/yyyy').format(date),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                          const CustomSpacing(width: 8,),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    ...items.map((plant) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔹 JAM (KOLOM KIRI)
                            SizedBox(
                              width: 60,
                              child: CustomText(
                                text: DateFormat('hh.mm a').format(plant.createdAt),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ),

                            CustomSpacing(width: 20,),

                            // 🔹 CARD (KANAN)
                            Expanded(
                              child: CustomJourneycard(
                                title: plant.title,
                                latinTitle: plant.latinTitle,
                                status: controller.statusText(plant.status),
                                width: double.infinity,
                                height: 160,
                                radius: 5,
                                onTap: () {},
                                statusColor: controller.statusColor(plant.status),
                                latinTitleColor:
                                    controller.latinTitleColor(plant.status),
                                backgroundColor:
                                    controller.backgroundColor(plant.status),
                                titleColor:
                                    controller.titleColor(plant.status), 
                                    trailing: Image.network(
                                      plant.imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                );
                
              }).toList(),
              
              );
            }),
            
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(18),
                        backgroundColor: const Color(0xFF2A9134)
                      ),
                      onPressed:  (){
                        Get.toNamed(
                          AppRoutes.cameraPage
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
    );
  }
}