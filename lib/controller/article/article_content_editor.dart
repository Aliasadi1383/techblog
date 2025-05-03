

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/manage_article_controller.dart';

class ArticleContentEditor extends StatelessWidget {
   ArticleContentEditor({super.key});
  final HtmlEditorController controller=HtmlEditorController();
  var manageArticleController=Get.put(ManageArticleController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap:  () => controller.clearFocus(),
     child: Scaffold(
      appBar: appBar('نوشتن / ویرایش مقاله'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HtmlEditor(controller: controller,
            htmlEditorOptions: HtmlEditorOptions(
              hint: 'میتونی مقاله‌تو اینجا بنویسی...',
              shouldEnsureVisible: true,
              initialText: manageArticleController.articleInfoModel.value.content!,
            ),
            callbacks: Callbacks(
              onChangeContent: (p0) {
                 manageArticleController.articleInfoModel.update((val) {
                   val?.content=p0;
                 },);
                debugPrint(manageArticleController.articleInfoModel.value.content.toString());
              },
            ),
            ),
          ],
        ),
      ),
     ),
    );
  }
}