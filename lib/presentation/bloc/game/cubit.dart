import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:figma_squircle/figma_squircle.dart';

import '../../../style/custom_decorations.dart';
import '../../../style/custom_shadows.dart';
import '../../../card_models.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());

  Widget buildProfile(bool isOpponent) {
    return Container(
      width: 435,
      height: 283,
      padding: const EdgeInsets.all(10),
      decoration: CustomDecorations.smoothLightShadowDark(54),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: CustomDecorations.smoothDark(44),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              padding: const EdgeInsets.all(11),
              decoration: CustomDecorations.smoothMainShadowDark(41),
              child: Container(
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(isOpponent ? 'images/missing_avatar1.jpg' : 'images/missing_avatar.jpg')
                  ),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 30,
                      cornerSmoothing: 1
                    )
                  )
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                isOpponent ? "НИКОПАВЕЛ" : "ВЛАД ЛАХТА",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                )
              )
            )
          ]
        )
      )
    );
  }

  //TODO: change according to design
  Widget buildPlayerCards(bool isOpponent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isOpponent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: isOpponent ? [
        cardWidget(characterCards[0], isActive: false),
        const SizedBox(width: 40),
        cardWidget(characterCards[1], isActive: false),
        const SizedBox(width: 58),
        cardWidget(characterCards[2], isActive: true)
      ] : [
        cardWidget(selectedCharacterCards[0], isActive: true),
        const SizedBox(width: 58),
        cardWidget(selectedCharacterCards[1], isActive: false),
        const SizedBox(width: 40),
        cardWidget(selectedCharacterCards[2], isActive: false)
      ]
    );
  }

  Widget cardWidget(CardModel card, {required bool isActive}) {
    double i = 3;//TODO:sector
    bool isUltimateUsed = true;
    return SizedBox(
      width: isActive ? 345 : 180,
      height: isActive ? 573 : 290,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            width: isActive ? 345 : 180,
            height: isActive ? 538 : 283,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(card.asset),
                ),
                boxShadow: CustomBoxShadows.shadowOnDark
              )
            )
          ),
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
                        child: Text("10", style: TextStyle(fontSize: isActive ? 32 : 18, color: Colors.white))
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
                    child: SvgPicture.string(
                      '''<svg width="200" height="200" viewBox="0 0 200 200">
                        <path 
                          d="M100 100L100 0 ${(i%4 > 2 || (i%4 == 0 && !isUltimateUsed)) ? 'A100 100 0 0 0 100 200' : ''}
                          A100 100 0 0 0 ${100 + 100 * cos((i + 1) * pi / 2)} ${100 + 100 * sin(-(i + 1) * pi / 2)}
                          L100 100Z"
                          fill="#FFFFFF"
                        />
                      </svg>'''
                    )
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}