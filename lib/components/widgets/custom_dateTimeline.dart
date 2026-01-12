import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomMonthSelector extends StatelessWidget {
  final int selectedMonth; 
  final Function(int) onChanged;

  const CustomMonthSelector({
    super.key,
    required this.selectedMonth,
    required this.onChanged,
  });

  static const List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, right: 25, left: 25,),
      
      child: SizedBox(
        height: 30,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: months.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final monthIndex = index + 1;
            final isSelected = monthIndex == selectedMonth;
      
            return GestureDetector(
              onTap: () => onChanged(monthIndex),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    months[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? PColor.primGreen
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2,
                    width: isSelected ? 20 : 0,
                    decoration: BoxDecoration(
                      color: PColor.primGreen,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}