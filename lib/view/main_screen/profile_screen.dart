import 'package:flutter/material.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Image(image: Assets.images.avatar.provider(), height: 100),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                Assets.icons.bluepen.provider(),
                color: SolidColors.seemore,
              ),
              const SizedBox(width: 8),
              Text(MyStrings.imageProfileEdit, style: textTheme.displaySmall),
            ],
          ),
          const SizedBox(height: 60),
          Text('علی اسدی', style: textTheme.headlineLarge),
          Text('fatemeamiri@gmail.com', style: textTheme.headlineLarge),
          const SizedBox(height: 40),
          TechDivider(size: size),
          InkWell(
            onTap: () {},
            splashColor: SolidColors.primaryColors,
            child: SizedBox(
              height: 45,
              child: Center(
                child: Text(
                  MyStrings.myFavBlog,
                  style: textTheme.headlineLarge,
                ),
              ),
            ),
          ), TechDivider(size: size),
          InkWell(
            onTap: () {},
            splashColor: SolidColors.primaryColors,
            child: SizedBox(
              height: 45,
              child: Center(
                child: Text(
                  MyStrings.myFavPodcast,
                  style: textTheme.headlineLarge,
                ),
              ),
            ),
          ), TechDivider(size: size),
          InkWell(
            onTap: () {},
            splashColor: SolidColors.primaryColors,
            child: SizedBox(
              height: 45,
              child: Center(
                child: Text(
                  MyStrings.logOut,
                  style: textTheme.headlineLarge,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
