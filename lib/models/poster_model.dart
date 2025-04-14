import 'package:tec/component/api_constant.dart';

class PosterModel {
  String? id;
  String? title;
  String? image;

  PosterModel({
    this.id,
    this.title,
    this.image,
  });
  PosterModel.fromjson(Map<String, dynamic> element) {
   id=element["id"];
   title=element["title"];
   image=ApiConstant.hostDlUrl+element["image"];
  }
}