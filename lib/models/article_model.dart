import 'package:tec/constant/api_constant.dart';

class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? catId;
  String? catName;
  String? author;
  String? view;
  String? status;
  //String? isFavorite;
  String? createdAt;

  ArticleModel({
   required this.id,
   required this.title,
   required this.image,
   required this.catId,
   required this.author,
   required this.view,
   required this.status,
   required this.createdAt,
  //this.isFavorite,
   required this.catName,
  });
  ArticleModel.fromjson(Map<String, dynamic> element) {
   id=element["id"];
   title=element["title"];
   image=ApiUrlConstant.hostDlUrl+element["image"];
   catId=element["cat_id"];
   catName=element["cat_name"];
   author=element["author"];
   view=element["view"];
   status=element["status"];
   createdAt=element["createdAt"];
  }
     

}