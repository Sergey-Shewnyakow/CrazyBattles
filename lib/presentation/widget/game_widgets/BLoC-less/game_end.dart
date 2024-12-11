import 'dart:ui' as ui;
import 'package:flutter/material.dart';

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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            widget.areYouWinningSon ? 'ПОБЕДА!' : 'ПОРАЖЕНИЕ!',
            style: const TextStyle(color: Colors.white, fontSize: 48),
          ),
        ]))
      ],
    );
  }
}
