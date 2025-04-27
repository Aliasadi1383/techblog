import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/articles/article_list_screen.dart';

var singleArticleController = Get.find<SingleArticleController>();

class Single extends StatelessWidget {
  const Single({super.key});

  @override
  Widget build(BuildContext context) {
    var textThem = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(
            () =>
                singleArticleController.articleInfoModel.value.id == null
                    ? SizedBox(height: Get.height, child: loading())
                    : Column(
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  singleArticleController
                                      .articleInfoModel
                                      .value
                                      .image!,
                              imageBuilder:
                                  (context, imageProvider) =>
                                      Image(image: imageProvider),
                              placeholder: (context, url) => loading(),
                              errorWidget:
                                  (context, url, error) => Image.asset(
                                    Assets.images.posterTest.path,
                                  ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    end: Alignment.bottomCenter,
                                    begin: Alignment.topCenter,
                                    colors: GradiantColors.singleAppbarGradiant,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Icon(
                                      Icons.bookmark_border_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 20),
                                    Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            singleArticleController
                                .articleInfoModel
                                .value
                                .title!,
                            maxLines: 2,
                            style: textThem.titleLarge,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image(
                                image:
                                    Image.asset(
                                      Assets.images.avatar.path,
                                    ).image,
                                height: 50,
                              ),
                              SizedBox(width: 16),
                              Text(
                                singleArticleController
                                    .articleInfoModel
                                    .value
                                    .author!,
                                style: textThem.headlineLarge,
                              ),
                              SizedBox(width: 16),
                              Text(
                                singleArticleController
                                    .articleInfoModel
                                    .value
                                    .createdAt!,
                                style: textThem.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HtmlWidget(
                            singleArticleController
                                .articleInfoModel
                                .value
                                .content!,
                            textStyle: textThem.bodySmall,
                            enableCaching: true,
                            onLoadingBuilder:
                                (context, element, loadingProgress) =>
                                    loading(),
                          ),
                        ),

                        tags(textThem),
                        SizedBox(height: 16),
                        simmilar(textThem),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}

Widget tags(textTheme) {
  return SizedBox(
    height: 35,

    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: singleArticleController.tagList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            var tagId = singleArticleController.tagList[index].id!;
            await Get.find<ListArticleController>().getArticleListWithTagsId(
              tagId,
            );
            String tagName = singleArticleController.tagList[index].title!;

            Get.to(ArticleListScreen(title: tagName));
          },
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Colors.grey,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text(
                  singleArticleController.tagList[index].title!,
                  style: textTheme.displayMedium,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget simmilar(textTheme) {
  return SizedBox(
    height: Get.height / 3.5,
    child: ListView.builder(
      itemCount: singleArticleController.releatedList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            singleArticleController.getArticleInfo(
              singleArticleController.releatedList[index].id
            );
          },
          child: Padding(
            padding: EdgeInsets.only(right: index == 0 ? Get.width / 15 : 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: Get.height / 5.3,
                    width: Get.width / 2.4,
                    child: CachedNetworkImage(
                      imageUrl:
                          singleArticleController.releatedList[index].image!,
                      imageBuilder:
                          (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // foregroundDecoration: BoxDecoration(
                            //   borderRadius: BorderRadius.all(Radius.circular(16)),
                            //   gradient: LinearGradient(
                            //     colors: GradiantColors.singleNewsGradiant,
                            //     begin: Alignment.center,
                            //     end: Alignment.bottomCenter,
                            //   ),
                            // ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:[ Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    singleArticleController
                                        .releatedList[index]
                                        .author!,
                                    style: textTheme.titleMedium,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    singleArticleController
                                        .releatedList[index]
                                        .view!,
                                        style: textTheme.titleMedium,
                                  ),
                                  Icon(
                                    Icons.remove_red_eye_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                              ]
                            ),
                          ),
                      placeholder: (context, url) => loading(),
                      errorWidget:
                          (context, url, error) => Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                            color: Colors.grey,
                          ),
                    ),
                  ),
                ),
          
                SizedBox(
                  width: Get.width / 2.4,
                  child: Text(
                    singleArticleController.releatedList[index].title!,
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
  );
}
