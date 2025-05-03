import 'package:flutter/rendering.dart';
import 'package:tec/constant/my_colors.dart';

class MyDecorations{
  MyDecorations._();
static BoxDecoration mainGradiant=const BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(20)),
  gradient: LinearGradient(colors: GradiantColors.bottomNav)
);
}