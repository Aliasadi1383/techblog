// ignore_for_file: prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/models/fake_data.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/view/articles/article_list_screen.dart';
import 'package:tec/view/articles/single.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  SingleArticleController singleArticleController = Get.put(SingleArticleController());
  ListArticleController listArticleController = Get.put(ListArticleController()); // ثبت ListArticleController

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Obx(
        () => Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: homeScreenController.loading.value == false
              ? Column(
                  children: [
                    poster(),
                    SizedBox(height: 16),
                    tags(),
                    SizedBox(height: 32),
                    GestureDetector(
                      onTap: () => Get.to(ArticleListScreen(title: 'مقالات جدید')),
                      child: SeeMore(
                        bodyMargin: bodyMargin,
                        textTheme: textTheme,
                        title: MyStrings.viewHotestBlog,
                      ),
                    ),
                    topVisited(),
                    SeeMorePodcast(bodyMargin: bodyMargin, textTheme: textTheme),
                    topPodcasts(),
                    SizedBox(height: 70),
                  ],
                )
              : const Center(child: loading()),
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
            return GestureDetector(
              onTap: () {
                singleArticleController.getArticleInfo(
                  homeScreenController.topVisitedList[index].id,
                );
                Get.to(Single());
              },
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: size.height / 5.3,
                        width: size.width / 2.4,
                        child: CachedNetworkImage(
                          imageUrl: homeScreenController.topVisitedList[index].image!,
                          imageBuilder: (context, imageProvider) => Container(
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
                          placeholder: (context, url) => loading(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                            color: Colors.grey,
                          ),
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
                    child: SizedBox(
                      width: size.width / 2.5,
                      height: size.height / 5.5,
                      child: CachedNetworkImage(
                        imageUrl: homeScreenController.topPodcasts[index].poster!,
                        imageBuilder: (context, imageProvider) => Container(
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
                        placeholder: (context, url) => const SpinKitFadingCube(
                          color: SolidColors.primaryColors,
                          size: 32,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
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

  Widget poster() {
    return Stack(
      children: [
        Container(
          width: size.width / 1.25,
          height: size.height / 4.2,
          child: CachedNetworkImage(
            imageUrl: homeScreenController.poster.value.image!,
            imageBuilder: (context, imageProvider) => Container(
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
            placeholder: (context, url) => loading(),
            errorWidget: (context, url, error) => Icon(
              Icons.image_not_supported_outlined,
              size: 50,
              color: Colors.grey,
            ),
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
                    homePagePosterMap["writer"] + " - " + homePagePosterMap["date"],
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

  Widget tags() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeScreenController.tagslist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var tagId = homeScreenController.tagslist[index].id;
              if (tagId == null) {
                Get.snackbar("خطا", "شناسه تگ پیدا نشد");
                return;
              }
              try {
                await listArticleController.getArticleListWithTagsId(tagId);
              } catch (e) {
                Get.snackbar("خطا", "نمی‌تونم مقالات رو بارگذاری کنم");
                return;
              }
              var tagName = homeScreenController.tagslist[index].title;
              if (tagName == null) {
                Get.snackbar("خطا", "نام تگ پیدا نشد");
                return;
              }
              Get.to(ArticleListScreen(title: tagName));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, index == 0 ? bodyMargin : 15, 8),
              child: MainTags(textTheme: textTheme, index: index),
            ),
          );
        },
      ),
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