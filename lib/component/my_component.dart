import 'package:flutter/material.dart';
import 'package:tec/fake_data.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/component/my_colors.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
     thickness: 1,
     color: SolidColors.dividerColor,
     indent: size.width/6,
     endIndent: size.width/6,
    );
  }
}

class MainTags extends StatelessWidget {
   MainTags({
    super.key,
    required this.textTheme,
    required this.index
  });

  final TextTheme textTheme;
  var index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        gradient: LinearGradient(
          colors: GradiantColors.tags,
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 8, 8, 8),
        child: Row(
          children: [
            ImageIcon(
              Assets.icons.hashtag.provider(),
              color: Colors.white,
              size: 16,
            ),
            SizedBox(width: 8),
            Text(
              tagList[index].title,
              style: textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
    