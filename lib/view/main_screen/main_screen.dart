import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/view/main_screen/home_screen.dart';
import 'package:tec/view/main_screen/profile_screen.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainScreen extends StatelessWidget {
  RxInt selectedPageIndex = 0.obs;

  MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size=MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          backgroundColor: SolidColors.scafoldBg,
          child: Padding(
            padding: EdgeInsets.only(right: Dimens.bodyMargin, left: Dimens.bodyMargin),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Image.asset(Assets.images.a1.path, scale: 3),
                  ),
                ),
                ListTile(
                  title: Text('پروفایل کاربر', style: textTheme.headlineLarge),
                  onTap: () {
                    selectedPageIndex.value=1;
                  },
                ),
                Divider(color: SolidColors.dividerColor),
                ListTile(
                  title: Text('درباره تک بلاگ', style: textTheme.headlineLarge),
                  onTap: () {},
                ),
                Divider(color: SolidColors.dividerColor),
                ListTile(
                  title: Text(
                    'اشتراک گذاری تک بلاگ',
                    style: textTheme.headlineLarge,
                  ),
                  onTap: () async{
                  await Share.share(MyStrings.shareText);
                  },
                ),
                Divider(color: SolidColors.dividerColor),
                ListTile(
                  title: Text(
                    'تک بلاگ در گیت هاب',
                    style: textTheme.headlineLarge,
                  ),
                  onTap: () {
                    myLaunchUrl(MyStrings.techBlogGithubUrl);
                  },
                ),
                Divider(color: SolidColors.dividerColor),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: SolidColors.scafoldBg,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  _key.currentState!.openDrawer();
                },

                child: Icon(Icons.menu),
              ),
              Image(
                image: Assets.images.a1.provider(),
                height: size.height / 13.6,
              ),
              Icon(Icons.search),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Obx(() => IndexedStack(
                  index: selectedPageIndex.value,
                  children: [
                    HomeScreen(
                      size: size,
                      textTheme: textTheme,
                      bodyMargin: Dimens.bodyMargin,
                    ),
                    ProfileScreen(
                      size: size,
                      textTheme: textTheme,
                      bodyMargin: Dimens.bodyMargin,
                    ),
                  ],
                ),),
              ),
              BottomNavigation(
                size: size,
                bodyMargin: Dimens.bodyMargin,
                changeScreen: (int value) {
                  
                    selectedPageIndex.value = value;
                
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
   const BottomNavigation({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
  });

  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      right: 0,
      left: 0,
      child: Container(
        height: size.height / 13,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: GradiantColors.bottomNavbackground,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
          child: Container(
            height: size.height / 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(colors: GradiantColors.bottomNav),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => changeScreen(0),
                  icon: ImageIcon(
                    Assets.icons.home.provider(),
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.find<RegisterController>().toggleLogin();
                  },
                  icon: ImageIcon(
                    Assets.icons.write.provider(),
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => changeScreen(1),
                  icon: ImageIcon(
                    Assets.icons.user.provider(),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
