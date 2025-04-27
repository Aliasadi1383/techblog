import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:tec/binding.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/my_http_overrides.dart';
import 'package:tec/view/articles/manage_article.dart';
import 'package:tec/view/articles/single.dart';
import 'package:tec/view/articles/single_manage_article.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/splash_screen.dart';


void main() async{
HttpOverrides.global=MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
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
     locale: Locale('fa'),
      theme: lightTheme(textTheme),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: NamedRoute.routeMainScreen, page:()=> MainScreen(),binding: RegisterBinding()),
        GetPage(name:NamedRoute.routeSingleArticle, page:()=> Single(),binding: ArticleBinding()),
        GetPage(name:NamedRoute.manageArticle, page:()=> ManageArticle(),binding: ArticleManagerBinding()),
        GetPage(name:NamedRoute.singleManageArticle, page:()=> SingleManageArticle(),binding: ArticleManagerBinding()),
      ],
      //home: SplashScreen(),
      home:SplashScreen(),
    );
  }

  ThemeData lightTheme(TextTheme textTheme) {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),
        
        borderSide: BorderSide(width: 2),
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
      textTheme: TextTheme(
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
          color: const Color.fromARGB(255, 70, 70, 70),
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



class NamedRoute{
static String routeMainScreen='/MainScreen';
static String routeSingleArticle='/SingleArticle';
static String manageArticle='/ManageArticle';
static String singleManageArticle='/SingleManageArticle';
}