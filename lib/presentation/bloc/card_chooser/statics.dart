import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Layout{
  static double get characterPanelWidthOrHeight => 250;
  static double get assistPanelWidth => 180;
  static double get assistPanelHeight => 544;
  static double get firstRowY => 215;
  static double get secondRowY => 509;
  static double get thirdRowY => 804;
  static double get firstColumnX => 104;
  static double get secondColumnX => 396;
  static double get characterTitleTopOffset => 90;
  static double get assistTitleTopOffset => 75;
}

class Titles{
  static Widget characterTitle(String title) {
    return SvgPicture.asset("images/ico$title.svg");
  }
  static Widget get assistTitle => const Text(
    "ПОДМОГА",
    style: TextStyle(
      color: Colors.white,
      fontSize: 30
    ),
  );
}