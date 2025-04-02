import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tec/data_models.dart';
import 'package:tec/fake_data.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/component/my_strings.dart';

class MyCats extends StatefulWidget {
  @override
  State<MyCats> createState() => _MyCatsState();
}

class _MyCatsState extends State<MyCats> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textThem = Theme.of(context).textTheme;
    var bodyMargin = size.width / 10;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 32),
                  SvgPicture.asset(Assets.images.tecbut.path, height: 100),
                  SizedBox(height: 16),
                  Text(
                    MyStrings.successfulRegistration,
                    style: textThem.headlineLarge,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: 'نام و نام خانوادگی',
                      hintStyle: textThem.headlineSmall,
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(MyStrings.chooseCats, style: textThem.headlineLarge),
                  //taglist
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: SizedBox(
                      width: double.infinity,
                      height: 90,
                      child: GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: tagList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 2,
                          childAspectRatio: 0.3,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains(tagList[index])) {
                                  selectedTags.add(tagList[index]);
                                }
                              });
                            },
                            child: MainTags(textTheme: textThem, index: index),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Image.asset(Assets.images.downCatArrow.path, scale: 3),
                  //selectedTags
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: SizedBox(
                      width: double.infinity,
                      height: 90,
                      child: GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: selectedTags.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 2,
                          childAspectRatio: 0.2,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                              color: SolidColors.surface,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(26, 8, 8, 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 8),
                                  Text(
                                    selectedTags[index].title,
                                    style: textThem.headlineLarge,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedTags.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
