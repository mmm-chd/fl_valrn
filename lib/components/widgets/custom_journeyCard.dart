import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomJourneycard extends StatelessWidget {
  CustomJourneycard(
    
    
    {super.key, 
    required this.statusColor,
    required this.latinTitleColor,
    required this.backgroundColor,
    required this.titleColor,
    required this.title, 
    required this.latinTitle, 
    required this.status, 
    required this.width, 
    required this.height, 
    required this.radius,
    required this.onTap, 
    this.trailing
    });
  final String title;
  final String latinTitle;
  final String status;
  final Color backgroundColor;
  final Color titleColor;
  final Color latinTitleColor;
  final Color statusColor;
  final double? radius;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Widget? trailing;


  @override
  Widget build(BuildContext context) {
    final borderRadius= BorderRadius.circular(radius ?? 16);
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 160,
      child: Material(
        color: backgroundColor,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🔹 TEKS KIRI (VERTIKAL KE BAWAH)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: titleColor,
                            ),
                          ),
                          CustomText(
                            text: latinTitle,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                              color: latinTitleColor,
                            ),
                          ),
                          const CustomSpacing(height: 6),
                          CustomText(
                            text: status,
                            maxLines: 3,
                            style: TextStyle(
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const CustomSpacing(width: 16),

                    // 🔹 FOTO KANAN (CENTER)
                    SizedBox(
                      width: 60,
                      height: 50,
                      child: Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: trailing ??
                              Icon(
                                Icons.sunny,
                                size: 50,
                                color: statusColor,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
            ),
        ),
      )
    );
  }
}