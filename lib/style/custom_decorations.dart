import 'package:flutter/material.dart';

import 'custom_colors.dart';
import 'custom_shadows.dart';
import 'package:figma_squircle/figma_squircle.dart'; // package for rounded corners

class CustomDecorations {
  static smoothDark(double size) => smoothColorable(size, CustomColors.greyDark);

  static smoothDarkShadowDark(double size) => smoothColorable(size, CustomColors.greyDark, shadows: CustomBoxShadows.shadowOnDark);

  static smoothLight(double size) => smoothColorable(size, CustomColors.greyLight);

  static smoothLightShadowDark(double size) => smoothColorable(size, CustomColors.greyLight, shadows: CustomBoxShadows.shadowOnDark);

  static smoothMain(double size) => smoothColorable(size, CustomColors.mainBright);

  static smoothMainShadowDark(double size) => smoothColorable(size, CustomColors.mainBright, shadows: CustomBoxShadows.shadowOnDark);

  static smoothColorable(double size, Color color, {List<BoxShadow>? shadows}) {
    return ShapeDecoration(
      shadows: shadows,
      color: color,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: size,
          cornerSmoothing: 1,
        ),
      ),
    );
  }

  static smoothColorableShadowDark(double size, Color color) =>smoothColorable(size, color, shadows: CustomBoxShadows.shadowOnDark);
}
