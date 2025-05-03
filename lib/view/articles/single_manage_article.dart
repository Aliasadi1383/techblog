import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/article_content_editor.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/services/piker_file.dart';

var manageArticleController = Get.find<ManageArticleController>();
 FilePikerController filePikerController=Get.put(FilePikerController());


class SingleManageArticle extends StatelessWidget {
  const SingleManageArticle({super.key});


  getTitle(){
    Get.defaultDialog(
      title: 'عنوان مقاله',
      titleStyle: const TextStyle(
          color: SolidColors.scafoldBg
        ),
      content: TextField(
        controller: manageArticleController.titleTextEditingController,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          color: SolidColors.colorTitle
        ),
        decoration: const InputDecoration(
          hintText: 'اینجا بنویس'
        ),
      ),
      backgroundColor: SolidColors.primaryColors,
      radius: 8,
      confirm: ElevatedButton(onPressed: () {
        manageArticleController.updateTitle();
        Get.back();
      }, child:const Text('ثبت'))
    );
  }

  @override
  Widget build(BuildContext context) {
    var textThem = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                      placeholder: (context, url) => const loading(),
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
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            colors: GradiantColors.singleAppbarGradiant,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                           
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
                            decoration: const BoxDecoration(
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
                                const Icon(Icons.add,color: Colors.white,)
                              ],
                            ),
                            
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
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
                
                GestureDetector(
                  onTap: () => Get.to(()=>ArticleContentEditor()),
                  child: SeeMore(bodyMargin: Dimens.halfBodyMargin, textTheme: textThem, title: 'ویرایش متن اصلی مقاله')),

              
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    manageArticleController.articleInfoModel.value.content!,
                    textStyle: textThem.bodySmall,
                    enableCaching: true,
                    onLoadingBuilder:
                        (context, element, loadingProgress) => const loading(),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
               GestureDetector(
                onTap: () {
                  chooseCatsBottomSheet(textThem);
                },
                child: SeeMore(bodyMargin: Dimens.halfBodyMargin, textTheme: textThem, title: 'انتخاب دسته بندی')),
               Padding(
                  padding:  EdgeInsets.all(Dimens.halfBodyMargin),
                  child: Text(
                    manageArticleController.articleInfoModel.value.catName==null?'هیچ دسته بندی انتخاب نشده':manageArticleController.articleInfoModel.value.catName!,
                    maxLines: 2,
                    style: textThem.titleLarge,
                  ),
                ),
                ElevatedButton(onPressed: ()async =>await manageArticleController.storeArticle() , 
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    manageArticleController.loading.value?
                    'صبر کنید...':
                    'ارسال مطلب'),
                )),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cats(textTheme) {
    var homeScreenController=Get.find<HomeScreenController>();
  return SizedBox(
    height: Get.height/1.7,

    child: GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: homeScreenController.tagslist.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
           
           manageArticleController.articleInfoModel.update((val) {
            val?.catId=homeScreenController.tagslist[index].id!;
             val?.catName=homeScreenController.tagslist[index].title!;
           },);
           Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              height: 30,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: SolidColors.primaryColors,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Center(
                  child: Text(
                    homeScreenController.tagslist[index].title!,
                    style: textTheme.displayMedium,
                  ),
                ),
              ),
            ),
          ),
        );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
    ),
  );
}

chooseCatsBottomSheet(TextTheme textThem){
Get.bottomSheet(
  Container(
    height: Get.height/1.5,
    width: Get.width,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20)
      )
    ),
    child:  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text('انتخاب دسته بندی'),
          const SizedBox(
            height: 8,
          ),
          cats(textThem),
        ],
        
      ),
      
    )
  ),
  isScrollControlled: true,
  persistent: true,
);
}
}

