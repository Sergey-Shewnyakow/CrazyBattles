import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cross_fade/cross_fade.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../style/custom_decorations.dart';
import '../../../style/custom_shadows.dart';
import '../../../style/custom_colors.dart';
import '../../../card_models.dart';
import 'game_model.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState(
    player1: PlayerModel(
      name: "НИКОПАВЕЛ",
      avatar : const AssetImage('images/missing_avatar1.jpg'),
      isOpponent: true,
      cards: CharacterCardGameModel.fromCardList([
        characterCards[0],
        characterCards[1],
        characterCards[2]
      ], isMy: false)
    ),
    player2: PlayerModel(
      name: "ВЛАД ЛАХТА",
      avatar : const AssetImage('images/missing_avatar.jpg'),
      isOpponent: false,
      cards: CharacterCardGameModel.fromCardList([
        selectedCharacterCards[0],
        selectedCharacterCards[1],
        selectedCharacterCards[2]
      ], isMy: true)
    ),
    time: 60
  ));
  static const int cardChangeDuration = 400;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      int time = state.time-1;
      if (time == 0) {
        emit(GameState(
          player1: state.player1,
          player2: state.player2,
          myTurn: !state.myTurn,
          isChangingActive: state.isChangingActive,
          timerValue: '1:00'
        ));
        return;
      }
      emit(GameState(
        player1: state.player1,
        player2: state.player2,
        myTurn: state.myTurn,
        isChangingActive: state.isChangingActive,
        timerValue: '${time~/60}:${time % 60 < 10 ? "0" : ""}${time % 60}',
        time: time
      ));
    });
  }


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
                    image: isOpponent ? state.player1.avatar : state.player2.avatar
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
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                isOpponent ? state.player1.name : state.player2.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
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

  Widget buildPlayerCardsSlots(bool isOpponent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isOpponent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: isOpponent ? [
        cardWidget(null),
        const SizedBox(width: 40),
        cardWidget(null),
        const SizedBox(width: 58),
        cardWidget(null, isActive: true)
      ] : [
        cardWidget(null, isActive: true),
        const SizedBox(width: 58),
        cardWidget(null),
        const SizedBox(width: 40),
        cardWidget(null)
      ]
    );
  }

  Widget buildPlayerCards(bool isOpponent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isOpponent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: isOpponent ? [
        cardWidget(state.player1.cards[2]),
        const SizedBox(width: 40),
        cardWidget(state.player1.cards[1]),
        const SizedBox(width: 58),
        cardWidget(state.player1.cards[0], isActive: true)
      ] : [
        clickableCardWidget(state.player2.cards[0], isActive: true),
        const SizedBox(width: 58),
        clickableCardWidget(state.player2.cards[1]),
        const SizedBox(width: 40),
        clickableCardWidget(state.player2.cards[2])
      ]
    );
  }

  Widget clickableCardWidget(CharacterCardGameModel card, {bool isActive = false}) {
    if (!state.myTurn) return cardWidget(card, isActive: isActive);
    return MouseRegion(
      cursor: state.isChangingActive == 0 ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: state.isChangingActive != 0 ? () => {}
          : card.isActive ? () => {} : () => changeActiveCardAnimate(card.number),
        child: cardWidget(card, isActive: isActive)
      )
    );
  }

  Widget cardWidget(CharacterCardGameModel? card, {bool isActive = false}) {
    if (card == null) {
      return SizedBox(
        width: isActive ? 345 : 180,
        height: isActive ? 573 : 290,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                width: isActive ? 345 : 180,
                height: isActive ? 538 : 283,
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.greyDark,
                    border: Border.all(
                      color: CustomColors.greyLight,
                      width: 5
                    )
                  )
                )
              )
            )
          ]
        )
      );
    }
    double ultimateProgress = card.ultimateProgress;//TODO:sector
    bool isUltimateUsed = true;//TODO: implement. false when the sector is full, true when it's empty
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
              decoration: (state.isChangingActive == 0 || state.isChangingActive == 3-card.number  || (state.myTurn != card.isMy)) ? 
                BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(card.asset),
                  ),
                  boxShadow: CustomBoxShadows.shadowOnDark
                )
                : const BoxDecoration()
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
                        child: CrossFade(
                          duration: const Duration(milliseconds: cardChangeDuration),
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
                      duration: const Duration(milliseconds: cardChangeDuration),
                      value: ultimateProgress,
                      builder: (context, i) => SvgPicture.string(
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
                )
              ]
            )
          )
        ]
      )
    );
  }

  Widget cardSwitcher() {
    if (state.isChangingActive == 0) return const SizedBox.shrink();
    return Animate(
      onInit: (controller) => controller.reset,
      onComplete: (controller) => changeActiveCardApply(),
      effects: [
        const Effect(duration: Duration(milliseconds: cardChangeDuration + 50)),
        CustomEffect(
          duration: const Duration(milliseconds: cardChangeDuration),
          builder: (_, value, child) => Stack(
            children: [
              Positioned(
                left: 139 + value*(402 + 220 * (state.isChangingActive - 1)),
                top: 947 + value*283,
                child: Container(
                  width: 180 + (165 * (1-value)),
                  height: 283 + (255 * (1-value)),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(state.player2.cards[state.isChangingActive].asset),
                    ),
                    boxShadow: CustomBoxShadows.shadowOnDark
                  )
                )
              ),
              Positioned(
                left: 541 + 220 * (state.isChangingActive - 1) - value*(402 + 220 * (state.isChangingActive - 1)),
                top: 1230 - value*283,
                child: Container(
                  width: 180 + (165 * value),
                  height: 283 + (255 * value),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(state.player2.cards[0].asset),
                    ),
                    boxShadow: CustomBoxShadows.shadowOnDark
                  )
                )
              )
            ]
          )
        )
      ]
    );
  }

  void changeActiveCardAnimate(int cardNum) {
    if (state.player2.energy < 1) return;
    state.player2.energy--;
    state.player2.setActiveCard(number: cardNum);
    emit(GameState(
      player1: state.player1,
      player2: state.player2,
      myTurn: state.myTurn,
      isChangingActive: cardNum,
      timerValue: state.timerValue,
      time: state.time
    ));
  }

  void changeActiveCardApply() {
    emit(GameState(
      player1: state.player1,
      player2: state.player2,
      myTurn: !state.myTurn,
      isChangingActive: 0,
      timerValue: state.timerValue
    ));
  }

  void changeTurn() {
    emit(GameState(
      player1: state.player1,
      player2: state.player2,
      myTurn: !state.myTurn,
      timerValue: state.timerValue
    ));
  }
}