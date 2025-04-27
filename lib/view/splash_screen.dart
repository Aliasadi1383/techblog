// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    Future.delayed(Duration(seconds: 3)).then((value) {
          Get.offAndToNamed(NamedRoute.routeMainScreen);

    },);

    super.initState();
  }

  @override
  Widget build(Object context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: Assets.images.a1.provider(), height: 64),
              SizedBox(height: 30),
              SpinKitFadingCube(color: SolidColors.primaryColors, size: 32),
            ],
          ),
        ),
      ),
    );
  }
}
