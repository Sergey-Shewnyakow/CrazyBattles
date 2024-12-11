
import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '/style/custom_decorations.dart';
import '/style/custom_shadows.dart';
import '/style/custom_colors.dart';
import '/game_models/card_models.dart';
import '/game_models/player_model.dart';
import '../../widget/game_widgets/BLoC-less/card_widget.dart';

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
    someoneSkipped: false
  ));
  static const int cardChangeDuration = 400;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      int time = state.time-1;
      if (time == 0) {
        emit(GameState(
          player1: state.player1,
          player2: state.player2,
          myTurn: state.someoneSkipped ? state.myTurn : !state.myTurn,
          someoneSkipped: state.someoneSkipped,
          isChangingActive: state.isChangingActive,
          timerValue: '1:00',
          isAttacking: state.isAttacking
        ));
        return;
      }
      emit(GameState(
        player1: state.player1,
        player2: state.player2,
        myTurn: state.myTurn,
        someoneSkipped: state.someoneSkipped,
        isChangingActive: state.isChangingActive,
        timerValue: '${time~/60}:${time % 60 < 10 ? "0" : ""}${time % 60}',
        time: time,
        isAttacking: state.isAttacking
      ));
    });
  }


  Widget buildProfile(bool isOpponent) {
    return Container(
      width: 435,
      height: 283,
      padding: const EdgeInsets.all(10),
      decoration: CustomDecorations.smoothColorableShadowDark(54, isOpponent != state.myTurn ? CustomColors.contrastBright : CustomColors.greyLight),
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

  Widget cardsOrSlotsRow(bool isOpponent, List<Widget> cards) { // layout for cards
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isOpponent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        cards[0],
        SizedBox(width: isOpponent ? 40 : 58),
        cards[1],
        SizedBox(width: isOpponent ? 58 : 40),
        cards[2]
      ]
    );
  }

  Widget buildPlayerCardsSlots(bool isOpponent) {
    return cardsOrSlotsRow(isOpponent, [
      CardWidget(isActive: !isOpponent),
      const CardWidget(),
      CardWidget(isActive: isOpponent)
    ]);
  }

  Widget buildPlayerCards(bool isOpponent) {
    return cardsOrSlotsRow(isOpponent, isOpponent ?
      [
        CardWidget(card: state.player1.cards[2], isVisible: state.isChangingActive == 0 || state.myTurn),
        CardWidget(card: state.player1.cards[1], isVisible: state.isChangingActive != 1 || state.myTurn),
        CardWidget(card: state.player1.cards[0], isActive: true, isVisible: state.isChangingActive != 2 || state.myTurn)
      ] : [
        clickableCardWidget(state.player2.cards[0], isActive: true),
        clickableCardWidget(state.player2.cards[1]),
        clickableCardWidget(state.player2.cards[2])
      ]
    );
  }

  Widget clickableCardWidget(CharacterCardGameModel card, {bool isActive = false}) {
    CardWidget cardWidget = CardWidget(card: card, isActive: isActive, isVisible: state.isChangingActive == 0 || state.isChangingActive == 3-card.number  || !state.myTurn);
    if (!state.myTurn || state.isChangingActive != 0) return cardWidget;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isActive ? () => AttackReady(true) : () => changeActiveCardAnimate(card.number),
        child: cardWidget
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
      someoneSkipped: state.someoneSkipped,
      isChangingActive: cardNum,
      timerValue: state.timerValue,
      time: state.time
    ));
  }

  void changeActiveCardApply() {
    emit(GameState(
      player1: state.player1,
      player2: state.player2,
      myTurn: state.someoneSkipped ? state.myTurn : !state.myTurn,
      someoneSkipped: state.someoneSkipped,
      isChangingActive: 0,
      timerValue: state.timerValue
    ));
  }

  void changeTurn() {
    if (!state.someoneSkipped) {
      emit(GameState(
        player1: state.player1,
        player2: state.player2,
        myTurn: !state.myTurn,
        someoneSkipped: true,
        timerValue: state.timerValue
      ));
    } else {nextRound();}
  }

  void nextRound() {
    state.player1.resetEnergy();
    state.player2.resetEnergy();
    emit(GameState(
      player1: state.player1,
      player2: state.player2,
      myTurn: !state.myTurn,
      someoneSkipped: false,
      timerValue: state.timerValue,
    ));
  }

  void AttackReady(bool value) {
    emit(GameState(
      player1: state.player1,
      player2: state.player2,
      myTurn: state.myTurn,
      someoneSkipped: state.someoneSkipped,
      isChangingActive: state.isChangingActive,
      timerValue: state.timerValue,
      time: state.time,
      isAttacking: value
    ));
  }

  void AttackDoneLetsChangeTurn() {
    emit(GameState(
      player1: state.player1,
      player2: state.player2,
      myTurn: !state.myTurn,
      someoneSkipped: state.someoneSkipped,
      timerValue: state.timerValue
    ));
  }

//TODO: attack button, ult button
  void attack() {
    //here
    AttackDoneLetsChangeTurn();
  }
  void ultimate() {
    //and here
    AttackDoneLetsChangeTurn();
  }
}