import 'package:fl_valrn/components/widgets/custom_dateTimeline.dart';
import 'package:fl_valrn/components/widgets/custom_journeyCard.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/journey_controller.dart';
import 'package:fl_valrn/dummy_data/dummyPlant.dart';
import 'package:fl_valrn/model/fields_model.dart';
import 'package:fl_valrn/model/plant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JourneyPage extends GetView<JourneyController> {
  JourneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FieldsItem field = Get.arguments;
    final List<PlantItem> plants = field.plants;

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row( 
              children: [ 
              IconButton( 
                onPressed: Get.back, 
                icon: Icon(Icons.arrow_back, size: 25,color: PColor.primGreen,)), 
                  Expanded(child: Center( 
                    child: CustomText(
                      text: "Journey", 
                      style: TextStyle( 
                        color: PColor.primGreen, 
                        fontSize: 30, fontWeight: FontWeight.w600 
                      ),), 
                    )),  
                  ], 
            ),
          ),

          Obx(() { 
            return  SizedBox( 
                height: 100, 
                child: CustomMonthSelector( 
                  selectedMonth: controller.selectedMonth.value, 
                  onChanged: controller.changeMonth, 
                ), 
             
            ); 
          }),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CustomJourneycard(
                    title: plant.title,
                    latinTitle: plant.latinTitle,
                    status: controller.statusText(plant.status),
                    width: 309,
                    height: 134,
                    radius: 5,
                    onTap: () {
                      // nanti bisa ke detail plant
                    },
                    statusColor: controller.statusColor(plant.status),
                    latinTitleColor:
                        controller.latinTitleColor(plant.status),
                    backgroundColor:
                        controller.backgroundColor(plant.status),
                    titleColor: controller.titleColor(plant.status),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(18),
                        backgroundColor: const Color(0xFF2A9134)
                      ),
                      onPressed: () {  },
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
    );
  }
}