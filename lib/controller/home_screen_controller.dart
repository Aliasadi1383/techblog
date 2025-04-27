import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/podcast_model.dart';
import 'package:tec/models/poster_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';

class HomeScreenController extends GetxController {
  late Rx<PosterModel> poster=PosterModel().obs;
  RxList<TagsModel> tagslist = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcasts = RxList();
  RxBool loading=false.obs;

 @override
  onInit(){
  super.onInit();
  getHomeItems();
 }
  getHomeItems() async {
    loading.value=true;
    var responce = await DioService().getMethod(ApiConstant.getHomeItems);

    if (responce.statusCode == 200) {
      responce.data['top_visited'].forEach((element) {
        topVisitedList.add(ArticleModel.fromjson(element));
      });
       responce.data['top_podcasts'].forEach((element) {
        topPodcasts.add(PodcastModel.fromjson(element));
      });
      responce.data['tags'].forEach((element) {
        tagslist.add(TagsModel.fromjson(element));
      });
      poster.value=PosterModel.fromjson(responce.data['poster']);
      loading.value=false;
    }
  }
}