import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'custom_shadows.dart'; //custom box shadows
import 'custom_colors.dart';//custom colors

class BorderedSocket extends StatelessWidget {
  final Widget? child;
  final double radius;
  final double height;
  final double width;
  final bool isBackBright;

  const BorderedSocket({
    super.key,
    this.radius = 0,
    this.isBackBright = false,
    this.height = 0,
    this.width = 0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (width > 0 && height > 0) Container(
          alignment: AlignmentDirectional.center,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: CustomColors.greyDark,
            borderRadius: BorderRadius.circular(radius+5),
            boxShadow: isBackBright
            ? CustomBoxShadows.shadowOnBright
            : CustomBoxShadows.shadowOnDark
          ),
          child: child,
        )
        else Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: CustomColors.greyDark,
            borderRadius: BorderRadius.circular(radius+5),
            border: Border.all(
              color: CustomColors.greyDark,
              width: 9,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            boxShadow: isBackBright
            ? CustomBoxShadows.shadowOnBright
            : CustomBoxShadows.shadowOnDark
          ),
          child: child,
        ),

        if (width > 0 && height > 0) DottedBorder(
          color: CustomColors.dottedBorderLine,
          padding: const EdgeInsets.all(11),
          strokeWidth: 8,
          radius: Radius.circular(radius),
          borderType: BorderType.RRect,
          dashPattern: const [
            24.2,
            22
          ],
          child: SizedBox(
            height: height-30,
            width: width-30,
          ),
        )
        else DottedBorder(
          color: CustomColors.dottedBorderLine,
          padding: const EdgeInsets.all(11),
          strokeWidth: 8,
          radius: Radius.circular(radius),
          borderType: BorderType.RRect,
          dashPattern: const [
            24.2,
            22
          ],
          child: Container(),
        ),
      ]
    );
  }
}