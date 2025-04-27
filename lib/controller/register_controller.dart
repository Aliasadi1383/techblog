// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/main.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/register/register_intro.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController =
      TextEditingController();
  var email = '';
  var userId = '';
  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register',
    };
    var responce = await DioService().postMethod(map, ApiConstant.postRegister);
    email = emailTextEditingController.text;
    userId = responce.data['user_id'];
    debugPrint(responce.toString());
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeTextEditingController.text,
      'command': 'verify',
      //response: verified, user_id: 585, token: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NTg1LCJlbWFpbCI6ImFsaWFzYWRpLjAxMjM0NTY3ODkxMEBnbWFpbC5jb20ifQ.YKSVxQ2QZWrutcSZ1FU8PIk1TFXVcgfpnPi8yr9uPvw}
    };
    debugPrint(map.toString());
    var responce = await DioService().postMethod(map, ApiConstant.postRegister);
    debugPrint(responce.data.toString());
    var status = responce.data['response'];

    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(StorageKey.token, responce.data['token']);
        box.write(StorageKey.userId, responce.data['user_id']);
        debugPrint('read:::' + box.read(StorageKey.token));
        debugPrint('read:::' + box.read(StorageKey.userId));
        Get.offAll(MainScreen());
        break;
      case 'false':
        Get.snackbar('خطا', 'کد فعال سازی غلط است');
        break;
      case 'expired':
        Get.snackbar('خطا', 'کد فعال سازی منقضی شده است');
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read(StorageKey.token) == null) {
      Get.to(RegisterIntro());
    } else {
      routeToWriteBottomSheet();
    }
  }

  routeToWriteBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height / 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(Assets.images.tecbut.path, height: 40),
                  SizedBox(width: 8),
                  Text('دونسته هات را با بقیه به اشتراک بگذار...'),
                ],
              ),
              SizedBox(height: 8),
              Text('''
فکر کن !!  اینجا بودنت به این معناست که یک گیک تکنولوژی هستی
دونسته هات رو با  جامعه‌ی گیک های فارسی زبان به اشتراک بذار..
'''),
SizedBox(height: 80,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(NamedRoute.manageArticle);
                    },
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.icons.writeArticleIcon.path,
                            height: 32,
                          ),
                          SizedBox(width: 8),
                          Text('مدیریت مقاله ها'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.icons.writePodcastIcon.path,
                            height: 32,
                          ),
                          SizedBox(width: 8),
                          Text('مدیریت پادکست ها'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
