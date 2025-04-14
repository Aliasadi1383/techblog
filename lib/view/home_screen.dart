// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/models/fake_data.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/component/my_strings.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child:Obx(
        ()=> Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
          child:  homeScreenController.loading.value==false? Column(
              children: [
                poster(),
                SizedBox(height: 16),
                HomePageTagList(bodyMargin: bodyMargin, textTheme: textTheme),
                SizedBox(height: 32),
                SeeMore(bodyMargin: bodyMargin, textTheme: textTheme),
                topVisited(),
                SeeMorePodcast(bodyMargin: bodyMargin, textTheme: textTheme),
                topPodcasts(),
                SizedBox(height: 70),
              ],
            ):const Center(child: loading()),
          ),
      ),
      );
  }

  Widget topVisited() {
    return SizedBox(
      height: size.height / 3.3,
      child: Obx(
        () => ListView.builder(
          itemCount: homeScreenController.topVisitedList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: size.height / 5.3,
                      width: size.width / 2.4,
                      child:  CachedNetworkImage(
                        imageUrl:
                            homeScreenController.topVisitedList[index].image!,
                        imageBuilder:
                            (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        placeholder:
                            (context, url) => loading(),
                            errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,size: 50,color: Colors.grey,),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: size.width / 2.4,
                    child: Text(
                      homeScreenController.topVisitedList[index].title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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

  Widget topPodcasts() {
    return SizedBox(
      height: size.height / 4.2,
      child: Obx(
        () => ListView.builder(
          itemCount: homeScreenController.topPodcasts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: size.width / 2.5,
                      height: size.height / 5.5,
                      child: CachedNetworkImage(
                        imageUrl:
                            homeScreenController.topPodcasts[index].poster!,
                        imageBuilder:
                            (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        placeholder:
                            (context, url) => const SpinKitFadingCube(
                              color: SolidColors.primaryColors,
                              size: 32,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,size: 50,color: Colors.grey,),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 2.5,
                    child: Text(homeScreenController.topPodcasts[index].title!),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

 Widget poster(){
  return Stack(
      children: [
        Container(
          width: size.width / 1.25,
          height: size.height / 4.2,
          child: CachedNetworkImage(
                        imageUrl:
                            homeScreenController.poster.value.image!,
                        imageBuilder:(context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        placeholder:
                            (context, url) => loading(),
                            errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,size: 50,color: Colors.grey,),
                      ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
              colors: GradiantColors.homeposterCoverGradiant,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    homePagePosterMap["writer"] +
                        " - " +
                        homePagePosterMap["date"],
                    style: textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        homePagePosterMap["View"],
                        style: textTheme.titleMedium,
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.remove_red_eye_sharp,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                homeScreenController.poster.value.title!,
                style: textTheme.displayLarge,
              ),
            ],
          ),
        ),
      ],
    );
 }

}



class SeeMorePodcast extends StatelessWidget {
  const SeeMorePodcast({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.microphone.provider(),
            color: SolidColors.seemore,
          ),
          SizedBox(width: 8),
          Text(MyStrings.viewHotestPodCasts, style: textTheme.displaySmall),
        ],
      ),
    );
  }
}

class SeeMore extends StatelessWidget {
  const SeeMore({super.key, required this.bodyMargin, required this.textTheme});

  final double bodyMargin;
  final TextTheme textTheme;

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
          SizedBox(width: 8),
          Text(MyStrings.viewHotestBlog, style: textTheme.displaySmall),
        ],
      ),
    );
  }
}

class HomePageTagList extends StatelessWidget {
  const HomePageTagList({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 8, index == 0 ? bodyMargin : 15, 8),
            child: MainTags(textTheme: textTheme, index: index),
          );
        },
      ),
    );
  }
}

