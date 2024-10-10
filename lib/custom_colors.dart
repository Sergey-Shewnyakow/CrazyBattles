import 'package:flutter/material.dart';

class CustomColors {
  static get greyDark => const Color.fromARGB(255, 16, 16, 16); //backround
  static get greyInfo =>
      const Color.fromARGB(255, 15, 15, 15); //grey in info menu
  static get cardSlot =>
      const Color.fromARGB(255, 28, 28, 28); //color for card slot
  static get greyLight => const Color.fromARGB(255, 40, 40,
      40); //for grey buttons and panels (for example: panel of card class choose)
  static get greyText => const Color.fromARGB(255, 104, 104, 104);
  static get inactiveText =>
      const Color.fromARGB(255, 139, 139, 139); //text on inactive start button
  static get dottedBorderLine =>
      const Color.fromARGB(255, 139, 139, 139); //color of border of card socket
  static get mainBright =>
      const Color.fromARGB(255, 134, 0, 255); //dominant color
  static get darkShadowMain => const Color.fromARGB(99, 0, 0, 0);
  static get darkShadowAdditional => const Color.fromARGB(87, 0, 0, 0);
  static get lightShadowMain => const Color.fromARGB(23, 10, 10, 10);
  static get lightShadowAdditional => const Color.fromARGB(16, 10, 10, 10);
}
