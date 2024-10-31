import 'package:flutter/material.dart';
import 'custom_colors.dart';//custom colors

class CustomBoxShadows {
  static List<BoxShadow> get shadowOnDark => [
    BoxShadow(
      color: CustomColors.darkShadowMain,
      blurRadius: 28,
      offset: const Offset(4,12),
    ),
    BoxShadow(
      color: CustomColors.darkShadowAdditional,
      blurRadius: 50,
      offset: const Offset(17,47),
    ),
  ];
  static List<BoxShadow> get shadowOnBright => [
    BoxShadow(
      color: CustomColors.lightShadowAdditional,
      blurRadius: 28,
      offset: const Offset(4,12),
    ),
    BoxShadow(
      color: CustomColors.lightShadowMain,
      blurRadius: 20,
      offset: const Offset(17,47),
    ),
  ];
}