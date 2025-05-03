import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/my_http_overrides.dart';
import 'package:tec/route_manager/names.dart';
import 'package:tec/route_manager/pages.dart';


void main() async{
HttpOverrides.global=MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      initialRoute:NamedRoute.initialRoute,
     locale: const Locale('fa'),
      theme: lightTheme(textTheme),
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
    //  home:SinglePodcast(),
    );
  }

  ThemeData lightTheme(TextTheme textTheme) {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),
        
        borderSide: const BorderSide(width: 2),
        ),
        filled: true,
        fillColor: Colors.white
      ),


      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          
          textStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return textTheme.displayLarge;
            }
            return textTheme.titleMedium;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return SolidColors.seemore;
            }
            return SolidColors.primaryColors;
          }),
        ),
      ),

      fontFamily: 'dubai',
      brightness: Brightness.light,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'dubai',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: SolidColors.posterTitle,
        ),
        titleMedium: TextStyle(
          fontFamily: 'dubai',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: SolidColors.postersubTitle,
        ),

        bodyLarge: TextStyle(
          fontFamily: 'dubai',
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
        displayMedium: TextStyle(
          fontFamily: 'dubai',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontFamily: 'dubai',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: SolidColors.seemore,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'dubai',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(255, 70, 70, 70),
        ),
        headlineSmall: TextStyle(
          fontFamily: 'dubai',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: SolidColors.hintText,
        ),
      ),
    );
  }
}


