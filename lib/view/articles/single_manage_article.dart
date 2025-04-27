import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/services/piker_file.dart';
import 'package:tec/view/articles/article_list_screen.dart';

var manageArticleController = Get.find<ManageArticleController>();
 FilePikerController filePikerController=Get.put(FilePikerController());


class SingleManageArticle extends StatelessWidget {
  const SingleManageArticle({super.key});


  getTitle(){
    Get.defaultDialog(
      title: 'عنوان مقاله',
      titleStyle: TextStyle(
          color: SolidColors.scafoldBg
        ),
      content: TextField(
        controller: manageArticleController.titleTextEditingController,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: SolidColors.colorTitle
        ),
        decoration: InputDecoration(
          hintText: 'اینجا بنویس'
        ),
      ),
      backgroundColor: SolidColors.primaryColors,
      radius: 8,
      confirm: ElevatedButton(onPressed: () {
        manageArticleController.updateTitle();
        Get.back();
      }, child:Text('ثبت'))
    );
  }

  @override
  Widget build(BuildContext context) {
    var textThem = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height/3,
                      child: filePikerController.file.value.name=='nothing'?
                    CachedNetworkImage(
                      imageUrl:
                          manageArticleController.articleInfoModel.value.image!,
                      imageBuilder:
                          (context, imageProvider) =>
                              Image(image: imageProvider),
                      placeholder: (context, url) => loading(),
                      errorWidget:
                          (context, url, error) =>
                              Image.asset(Assets.images.posterTest.path,fit: BoxFit.cover,),
                    ):
                    Image.file(File(filePikerController.file.value.path!),
                    fit: BoxFit.cover,
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
                           
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            pikerFile();
                          },
                          child: Container(
                            height: 30,
                            width: Get.width/3,
                            decoration: BoxDecoration(
                              color: SolidColors.primaryColors,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('انتخاب تصویر',style: textThem.displayMedium,),
                                Icon(Icons.add,color: Colors.white,)
                              ],
                            ),
                            
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    getTitle();
                  },
                  child: SeeMore(bodyMargin: Dimens.halfBodyMargin, textTheme: textThem, title: 'ویرایش عنوان مقاله')),
                Padding(
                  padding:  EdgeInsets.all(Dimens.halfBodyMargin),
                  child: Text(
                    manageArticleController.articleInfoModel.value.title!,
                    maxLines: 2,
                    style: textThem.titleLarge,
                  ),
                ),
                
                SeeMore(bodyMargin: Dimens.halfBodyMargin, textTheme: textThem, title: 'ویرایش متن اصلی مقاله'),

              
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    manageArticleController.articleInfoModel.value.content!,
                    textStyle: textThem.bodySmall,
                    enableCaching: true,
                    onLoadingBuilder:
                        (context, element, loadingProgress) => loading(),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
               SeeMore(bodyMargin: Dimens.halfBodyMargin, textTheme: textThem, title: 'انتخاب دسته بندی'),
              
                //tags(textThem),
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
      itemCount: manageArticleController.tagList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            var tagId = manageArticleController.tagList[index].id!;
            await Get.find<ListArticleController>().getArticleListWithTagsId(
              tagId,
            );
            String tagName = manageArticleController.tagList[index].title!;

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
                  manageArticleController.tagList[index].title!,
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
