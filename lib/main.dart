import 'package:fl_valrn/configs/pages.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: HColor.bgWhite,
        colorScheme: ColorScheme.light(
          surface: Colors.white,
          background: Colors.white,
          primary: PColor.primGreen,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: HColor.bgWhite,
          elevation: 0,
          surfaceTintColor: HColor.bgWhite,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
      ),
      initialRoute: AppRoutes.marketPage,
      getPages: AppPages.pages,
    );
  }
}
