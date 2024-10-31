import 'package:flutter/material.dart';

import 'custom_colors.dart';
import 'custom_shadows.dart';
import 'package:figma_squircle/figma_squircle.dart'; // package for rounded corners

class CustomDecorations {
  static smoothDark(double size) {
    return ShapeDecoration(
      color: CustomColors.greyDark,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: size,
          cornerSmoothing: 1,
        ),
      ),
    );
  }

  static smoothDarkShadowDark(double size) {
    return ShapeDecoration(
      shadows: CustomBoxShadows.shadowOnDark,
      color: CustomColors.greyDark,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: size,
          cornerSmoothing: 1,
        ),
      ),
    );
  }

  static smoothLight(double size) {
    return ShapeDecoration(
      color: CustomColors.greyLight,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: size,
          cornerSmoothing: 1,
        ),
      ),
    );
  }

  static smoothLightShadowDark(double size) {
    return ShapeDecoration(
      shadows: CustomBoxShadows.shadowOnDark,
      color: CustomColors.greyLight,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: size,
          cornerSmoothing: 1,
        ),
      ),
    );
  }

  static smoothMain(double size) {
    return ShapeDecoration(
      color: CustomColors.mainBright,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: size,
          cornerSmoothing: 1,
        ),
      ),
    );
  }

  static smoothMainShadowDark(double size) {
    return ShapeDecoration(
      shadows: CustomBoxShadows.shadowOnDark,
      color: CustomColors.mainBright,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: size,
          cornerSmoothing: 1,
        ),
      ),
    );
  }
}
