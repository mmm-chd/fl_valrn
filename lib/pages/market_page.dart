import 'package:fl_valrn/components/widgets/custom_card.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/controllers/market_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketPage extends GetView<MarketController> {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.pin_drop_sharp, color: Color(0xff2A9134), size: 40,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Kecamatan {Kecamatan}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CustomText(
                        text: "Kabupaten {Kabupaten}, Provinsi",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              CustomSpacing(height: 25,),
              CustomTextfield(
                isNumber: false, 
                controller: controller.searchController,
                label: 'Cari tanaman kamu..',
              ),

              CustomSpacing(
                height: 20,
              ),
              CustomCard(
                title: "ngetes",
                subtitle: "muncul kaga",
                imageUrl: "https://i.pinimg.com/736x/2f/de/99/2fde9942cfc7d25f34411c9ca1d8990f.jpg",
                isExtendable: false,
                isEcommerce: true,
                isDescription: false,
                width: double.infinity, 
              ),

              CustomSpacing(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Popular Categories",
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),),
                  Spacer(),
                  CustomText(
                    text: "See all",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2A9134)
                    ),)
                ],
              ),
              CustomSpacing(height: 12,),
              Obx((){
                if (controller.isLoading.value) {
                    return SizedBox(
                      height: 220,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
          
                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.trendingCard.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                          title: controller.trendingCard[index].title, 
                          subtitle: controller.trendingCard[index].subtitle, 
                          imageUrl: controller.trendingCard[index].imageUrl, 
                          isExtendable: false, isEcommerce: false, isDescription: false, 
                          height: 152,
                          width: 120, isImageLeft: false,
                        );
                      },
                    ),
                  );
              }),
              CustomSpacing(height: 20,),
              CustomText(
                    text: "Mungkin kamu tertarik",
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
              ),),
              CustomSpacing(height: 12,),
              Obx((){
                if (controller.isLoading.value) {
                    return SizedBox(
                      height: 220,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
          
                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.productCard.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                          title: controller.productCard[index].title, 
                          subtitle: controller.productCard[index].subtitle, 
                          imageUrl: controller.productCard[index].imageUrl,
                          rate: controller.productCard[index].rate,
                          price: controller.productCard[index].price, 
                          isExtendable: false, isEcommerce: true, isDescription: true, 
                          textSize: 20,
                          height: 240,
                          width: 260, isImageLeft: false,
                        );
                      },
                    ),
                  );
              }),
              CustomSpacing(height: 20,),
              
              Obx(() {
                    if (controller.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.productCard.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 8,
                        childAspectRatio: 180 / 244, 
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.productCard[index];

                        return CustomCard(
                          title: item.title,
                          subtitle: item.subtitle,
                          imageUrl: item.imageUrl,
                          rate: item.rate,
                          price: item.price,
                          isEcommerce: true,
                          isDescription: true,
                          height: 244,
                          width: 184,
                          isImageLeft: false,
                          textSize: 14,
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}