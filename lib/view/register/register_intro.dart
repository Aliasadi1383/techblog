// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:validators/validators.dart';

class RegisterIntro extends StatelessWidget {
   RegisterIntro({super.key});

  var registerController=Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.images.tecbut.path, height: 100),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: MyStrings.welcom,
                    style: textTheme.headlineLarge,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    _showEmailBottomSheet(context, size, textTheme);
                  },
                  child: Text('بزن بریم'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showEmailBottomSheet(BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: size.height/2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(MyStrings.insetrYourEmail,style: textTheme.headlineLarge,),
                                Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: TextField(
                                    controller: registerController.emailTextEditingController,
                                    onChanged: (value) {
                                      debugPrint("${value}is Email = ${isEmail(value)}");
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: 'tecblog@gmail.com',
                                      hintStyle: textTheme.headlineSmall
                                    ),
                                  ),
                                ),
                                ElevatedButton(onPressed: ()async{
                                  registerController.register();
                                  Navigator.pop(context);
                               _activateCodeEmailBottomSheet(context, size, textTheme);
                                }, child: Text('ادامه')),
                              ],
                            ),
                          )
                        ),
                      );
                    },
                  );
  }  Future<dynamic> _activateCodeEmailBottomSheet(BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: size.height/2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(MyStrings.activateCode,style: textTheme.headlineLarge,),
                                Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: TextField(
                                    controller: registerController.activeCodeTextEditingController,
                                    onChanged: (value) {
                                      debugPrint("${value}is Email = ${isEmail(value)}");
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: '******',
                                      hintStyle: textTheme.headlineSmall
                                    ),
                                  ),
                                ),
                                ElevatedButton(onPressed: (){
                                  registerController.verify();
                                // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyCats(),));
                                }, child: Text('ادامه')),
                              ],
                            ),
                          )
                        ),
                      );
                    },
                  );
  }
}
