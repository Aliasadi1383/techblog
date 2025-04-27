// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';

class SingleArticleController extends GetxController{
 
   RxBool loading=false.obs;
  RxInt id=RxInt(0);
  Rx<ArticleInfoModel>articleInfoModel=ArticleInfoModel(null,null,null).obs;
  RxList<TagsModel>tagList=RxList();
  RxList<ArticleModel>releatedList=RxList();
 
  getArticleInfo(var id) async {
    articleInfoModel=ArticleInfoModel(null,null,null).obs;
    loading.value=true;
    var userId='';
    debugPrint(ApiConstant.baseurl+'article/get.php?command=info&id=$id&user_id=$userId');
    var responce = await DioService().getMethod(ApiConstant.baseurl+'article/get.php?command=info&id=$id&user_id=$userId');

    if (responce.statusCode == 200) {
      articleInfoModel.value=ArticleInfoModel.fromjson(responce.data);
      loading.value=false;
    }
    tagList.clear();
    responce.data['tags'].forEach((element){
      tagList.add(TagsModel.fromjson(element));
    });
     releatedList.clear();
    responce.data['related'].forEach((element){
      releatedList.add(ArticleModel.fromjson(element));
    });
  }
 
}