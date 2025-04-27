// ignore_for_file: sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/main.dart';

class ManageArticle extends StatelessWidget {
   ManageArticle({super.key});

  var articleManageController=Get.find<ManageArticleController>();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: appBar('مدیریت مقاله'),
        body:  Obx(
              ()=>articleManageController.loading.value?loading():articleManageController.articleList.isNotEmpty? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: articleManageController.articleList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                       
                      
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height/7,
                              width: size.width/3,
                              child: CachedNetworkImage(
                                imageUrl: articleManageController.articleList[index].image!,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(16)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) {
                                  return loading();
                                },
                                errorWidget: (context, url, error) {
                                  return Icon(Icons.image_not_supported_outlined,size: 50,color: Colors.grey,);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width/2,
                                  child: Text(articleManageController.articleList[index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(articleManageController.articleList[index].author!,style: textTheme.bodySmall,),
                                    SizedBox(width:10),
                                    Text("${articleManageController.articleList[index].view!} بازدید",style: textTheme.bodySmall,),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ):articleEmptyState(textTheme),
            ),
      
      bottomNavigationBar:   Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  
                  style: ButtonStyle(fixedSize: WidgetStateProperty.all(Size(Get.width/3, 56))),
                  onPressed: () {
                    Get.toNamed(NamedRoute.singleManageArticle);
                  },
                  child: Text('بریم برای نوشتن یه مقاله باحال' ,style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
      ),
    );
  }

  Widget articleEmptyState(TextTheme textTheme) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.images.emptyState.path, height: 100),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  
                  text: MyStrings.articleEmpty,
                  style: textTheme.headlineLarge,
                  
                ),
              ),
            ),
          
          ],
        ),
      );
  }

}