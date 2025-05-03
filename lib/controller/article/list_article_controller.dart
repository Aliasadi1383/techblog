import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/services/dio_service.dart';

class ListArticleController extends GetxController{
  RxList<ArticleModel> articleList=RxList();
   RxBool loading=false.obs;

 @override
  onInit(){
  super.onInit();
  getList();
 }
  getList() async {
    loading.value=true;
    var responce = await DioService().getMethod(ApiUrlConstant.getArticleList);

    if (responce.statusCode == 200) {
      responce.data.forEach((element) {
        articleList.add(ArticleModel.fromjson(element));
      });
      loading.value=false;
    }
  } 
  
   getArticleListWithTagsId(String id) async {
    articleList.clear();
    loading.value=true;
    var responce = await DioService().getMethod('${ApiUrlConstant.baseurl}article/get.php?command=get_articles_with_tag_id&tag_id=$id&user_id=');

    if (responce.statusCode == 200) {
      responce.data.forEach((element) {
        articleList.add(ArticleModel.fromjson(element));
      });
      loading.value=false;
    }
  }

}