import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../../style/custom_decorations.dart';

class EndGameWidget extends StatefulWidget {
  final bool areYouWinningSon;

  const EndGameWidget({super.key, required this.areYouWinningSon});

  @override
  State<EndGameWidget> createState() => EndGameWidgetState();
}

class EndGameWidgetState extends State<EndGameWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.areYouWinningSon ? 'ПОБЕДА!' : 'ПОРАЖЕНИЕ!',
                style: const TextStyle(color: Colors.white, fontSize: 48),
              ),
              const SizedBox(height: 70),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => {CardGameApp.toMenu()},
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 300,
                    decoration: CustomDecorations.smoothMain(51),
                    child: const Text(
                      "МЕНЮ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40
                      )
                    )
                  )
                )
              )
            ]
          )
        )
      ],
    );
  }
}
