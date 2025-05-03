import 'dart:developer';

import 'package:dio/dio.dart'as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/commands.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';

class ManageArticleController extends GetxController{
  RxList<ArticleModel>articleList=RxList.empty();
  RxList<TagsModel>tagList=RxList.empty();
  RxBool loading=false.obs;
  TextEditingController titleTextEditingController=TextEditingController();
  Rx<ArticleInfoModel>articleInfoModel=ArticleInfoModel('اینجا عنوان مقاله قرار میگیره ، یه عنوان جذاب انتخاب کن', '''
من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی
''', '').obs;

 @override
 onInit(){
  super.onInit();
  getManagedArticle();
  
 }

  getManagedArticle()async{
    loading.value=true;
   // var responce = await DioService().getMethod(ApiConstant.publishedByMe+GetStorage().read(StorageKey.userId));
    var responce = await DioService().getMethod('${ApiUrlConstant.publishedByMe}1');

    if (responce.statusCode == 200) {
      responce.data.forEach((element) {
        articleList.add(ArticleModel.fromjson(element));
      });
      //articleList.clear();
      loading.value=false;
    }
  }
  updateTitle(){
    articleInfoModel.update((val) {
      val!.title=titleTextEditingController.text;
    },);
  }
  storeArticle()async{
    var fileController=Get.find<FilePikerController>();
    loading.value=true;
    Map<String,dynamic> map={
    ApiArticleKeyConstant.title:articleInfoModel.value.title,
    ApiArticleKeyConstant.content:articleInfoModel.value.content,
    ApiArticleKeyConstant.catId:articleInfoModel.value.catId,
    ApiArticleKeyConstant.userId:GetStorage().read(StorageKey.userId),
    ApiArticleKeyConstant.image:await dio.MultipartFile.fromFile(fileController.file.value.path!),
    ApiArticleKeyConstant.command:Commands.store,
    ApiArticleKeyConstant.tagList:"[]",

    };
    var responce = await DioService().postMethod(map,ApiUrlConstant.articlePost);
    log(responce.data.toString());
    loading.value=false;
  }

}