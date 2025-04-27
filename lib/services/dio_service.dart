// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;

class DioService {
  Dio dio = Dio();
  Future<dynamic> getMethod(String url) async {
    dio.options.headers["content-type"] = 'application/json';
    return await dio
        .get(
          url,
          options: Options(responseType: ResponseType.json, method: 'GET'),
        )
        .then((response) {
          log(response.toString());
          return response;
        }).catchError((error){
        if(error is DioException){
          return error.response!;
        }
        });
  }

  Future<dynamic>postMethod(Map<String,dynamic>map,String url)async{
   dio.options.headers["content-type"] = 'application/json';

   return await dio.post(url,data: dio_service.FormData.fromMap(map),options: Options(
    
    responseType: ResponseType.json,
    method: 'POST',
   )).then((response) {
     log(response.headers.toString());
     log(response.data.toString());
     log(response.statusCode.toString());
     return response;
   }).catchError((error){
   if(error is DioException){
    return error.response!;
   }
   });

  }
}
