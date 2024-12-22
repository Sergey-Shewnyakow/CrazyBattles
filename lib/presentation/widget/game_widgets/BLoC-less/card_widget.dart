import 'dart:math';

import 'package:crazy_battles/style/custom_colors.dart';
import 'package:crazy_battles/style/custom_shadows.dart';
import 'package:cross_fade/cross_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../game_models/player_model.dart';
import '../../../../style/custom_decorations.dart';


class CardWidget extends StatefulWidget {
  final CharacterCardGameModel? card;
  final bool isActive;
  final bool isVisible;
  static const int cardChangeDuration = 400;

  const CardWidget({
    super.key,
    this.card,
    this.isActive = false,
    this.isVisible = false
  });

  @override
  State<CardWidget> createState() => card == null ? EmptyCardWidgetState() : CardWidgetState();
}

class EmptyCardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    bool isActive = widget.isActive;
    return SizedBox(
      width: isActive ? 345 : 180,
      height: isActive ? 573 : 290,
      child: Stack(
        alignment: Alignment.center,
        children: childrenList()
      )
    );
  }

  List<Widget> childrenList() => [positionedSlot()];

  Widget positionedSlot() {
    bool isActive = widget.isActive;
    return Positioned(
      top: 0,
      width: isActive ? 345 : 180,
      height: isActive ? 538 : 283,
      child: slot()
    );
  }

  Widget slot() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.greyDark,
        border: Border.all(
          color: CustomColors.greyLight,
          width: 5
        )
      )
    );
  }
}

class CardWidgetState extends EmptyCardWidgetState {
  @override
  List<Widget> childrenList() {
    CharacterCardGameModel card = widget.card!;
    bool isActive = widget.isActive;
    double ultimateProgress = card.ultimateProgress;
    return [
      positionedSlot(),
      Positioned(
        bottom: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isActive ? 150 : 90,
              height: isActive ? 80 : 49,
              decoration: isActive ? CustomDecorations.smoothMain(20) : CustomDecorations.smoothLight(13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("images/HP.svg", height: isActive ? 32 : 18),
                  SizedBox(width: isActive ? 15 : 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: CrossFade(
                      duration: const Duration(milliseconds: CardWidget.cardChangeDuration),
                      value: card.hp,
                      builder: (context, i) => Text("$i", style: TextStyle(fontSize: isActive ? 32 : 18, color: Colors.white))
                    )
                  )
                ],
              ),
            ),
            SizedBox(width: isActive ? 30 : 15),
            Container(
              width: isActive ? 100 : 57,
              height: isActive ? 85 : 52,
              decoration: isActive ? CustomDecorations.smoothMain(25) : CustomDecorations.smoothLight(16),
              child: Padding(
                padding: EdgeInsets.all(isActive ? 20 : 13),
                child: CrossFade(
                  duration: const Duration(milliseconds: CardWidget.cardChangeDuration),
                  value: ultimateProgress,
                  builder: (context, i) => SvgPicture.string(
                    '''<svg width="200" height="200" viewBox="0 0 200 200">
                      <path 
                        d="M100 100L100 0 ${(i%4 > 2 || (i==4)) ? 'A100 100 0 0 0 100 200' : ''}
                        A100 100 0 0 0 ${100 + 100 * cos((i + 1) * pi / 2)} ${100 + 100 * sin(-(i + 1) * pi / 2)}
                        L100 100Z"
                        fill="#FFFFFF"
                      />
                    </svg>'''
                  )
                )
              )
            )
          ]
        )
      )
    ];
  }

  @override
  Widget slot() {
    return Container(
      decoration: (widget.isVisible) ? 
        BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.card!.asset),
          ),
          boxShadow: CustomBoxShadows.shadowOnDark
        )
        : const BoxDecoration()
    );
  }
}
