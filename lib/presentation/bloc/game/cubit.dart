
import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../style/custom_decorations.dart';
import '../../../style/custom_shadows.dart';
import '../../../card_models.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());

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
                      SvgPicture.asset("images/HP.svg", color: Colors.white, height: isActive ? 32 : 18), //TODO: AAAAAA Why TF color is needed
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
                  decoration: isActive ? CustomDecorations.smoothMain(25) : CustomDecorations.smoothLight(16)
                )
              ],
            )
          )
        ],
      )
    );
  }
}