// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, camel_case_types

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/component/text_style.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
     thickness: 1,
     color: SolidColors.dividerColor,
     indent: size.width/6,
     endIndent: size.width/6,
    );
  }
}

class MainTags extends StatelessWidget {
   MainTags({
    super.key,
    required this.textTheme,
    required this.index
  });

  final TextTheme textTheme;
  var index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        gradient: LinearGradient(
          colors: GradiantColors.tags,
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 8, 8, 8),
        child: Row(
          children: [
            ImageIcon(
              Assets.icons.hashtag.provider(),
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              Get.find<HomeScreenController>().tagslist[index].title!,
              style: textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
    
 myLaunchUrl(String url)async{
 var uri=Uri.parse(url);
 if(await canLaunchUrl(uri)){
  await launchUrl(uri);
 }else{
  log('could not launch ${uri.toString()}');
 }

 }

 class loading extends StatelessWidget {
  const loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCube(
      color: SolidColors.primaryColors,
      size: 32,
    );
  }
}
  PreferredSize appbar(String title) {
    return PreferredSize(
          preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AppBar(
              backgroundColor: Colors.transparent,
           actions: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Center(child: Text(title,style: appbartextstyle,)),
              )
           ],
           leading: Padding(
             padding: const EdgeInsets.only(right: 16),
             child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: SolidColors.primaryColors.withBlue(100),
                    shape: BoxShape.circle
                ),
                child: const Icon(Icons.keyboard_arrow_right_rounded),
             ),
           ),
          ),
        ),
      );
  }
  PreferredSize appBar(String title) {
    return PreferredSize(
          preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AppBar(
              backgroundColor: Colors.transparent,
           actions: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Center(child: Text(title,style: appbartextstyle,)),
              )
           ],
           leading: GestureDetector(
            onTap: () {
              Get.back();
            },
             child: Padding(
               padding: const EdgeInsets.only(right: 16),
               child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: SolidColors.primaryColors.withBlue(100),
                      shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.keyboard_arrow_right_rounded,color: SolidColors.lightText,),
               ),
             ),
           ),
          ),
        ),
      );
  }
 

class SeeMore extends StatelessWidget {
  const SeeMore({super.key, required this.bodyMargin, required this.textTheme,required this.title});

  final double bodyMargin;
  final TextTheme textTheme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.bluepen.provider(),
            color: SolidColors.seemore,
          ),
          const SizedBox(width: 8),
          Text(title, style: textTheme.displaySmall),
        ],
      ),
    );
  }
}



