// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/route_manager/names.dart';

class ArticleListScreen extends StatelessWidget {
    String title;

  ArticleListScreen({super.key,required this.title});
  ListArticleController listarticleController = Get.put(ListArticleController());
  SingleArticleController singleArticleController = Get.put(SingleArticleController());

  @override
  Widget build(BuildContext context) {
   var size = MediaQuery.of(context).size;
   var textTheme=TextTheme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: appBar(title),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Obx(
              ()=> ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: listarticleController.articleList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async{
                       
                      await singleArticleController.getArticleInfo(
                       listarticleController.articleList[index].id
                       );
                     Get.toNamed(NamedRoute.routeSingleArticle);
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
                                imageUrl: listarticleController.articleList[index].image!,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) {
                                  return const loading();
                                },
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.image_not_supported_outlined,size: 50,color: Colors.grey,);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width/2,
                                  child: Text(listarticleController.articleList[index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(listarticleController.articleList[index].author!,style: textTheme.bodySmall,),
                                    const SizedBox(width:10),
                                    Text("${listarticleController.articleList[index].view!} بازدید",style: textTheme.bodySmall,),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
            ),
          ),
        ),
        
      ),
    );
  }
}
