import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/view/main_screen.dart';
import 'package:tec/view/my_cats.dart';
import 'package:tec/view/register_intro.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa'), // farsi
      ],

      title: 'Flutter Demo',
      theme: ThemeData(
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
      ),
      debugShowCheckedModeBanner: false,
      //home: SplashScreen(),
      home: MyCats(),
    );
  }
}
