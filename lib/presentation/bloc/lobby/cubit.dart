import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart'; // flutter visual lib
import 'package:flutter_animate/flutter_animate.dart'; // animations lib

import '../../../style/custom_decorations.dart';
import '../../../card_models.dart'; // models of cards, game and players, cards data

class LobbyCubit extends Cubit<LobbyState> {
  LobbyCubit() : super(const LobbyState(isProfileAnimated: true));

  void moveCardToSlot(CardModel card) {
    emit(LobbyState(
      isProfileAnimated: state.isProfileAnimated,
      movableCard: card,
      isMoving: true
    ));
  }

  Widget movingCard() {
    if (state.movableCard == null) return const SizedBox.shrink();
    return Animate(
      onComplete: (controller) => _endMove(),
      effects: [
        MoveEffect(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastEaseInToSlowEaseOut,
          begin: const Offset(360, 946),
          end: state.movableCard!.isAssist
              ? Offset(selectedAssistCards.length == 1 ? 180 : 2450, 4327)
              : Offset(
                  selectedCharacterCards.length == 1
                      ? 493
                      : selectedCharacterCards.length == 2
                          ? 913
                          : 1333,
                  2905),
        ),
        ScaleEffect(
          duration: const Duration(milliseconds: 800),
          begin: const Offset(1, 1),
          end: state.movableCard!.isAssist
              ? const Offset(0.27, 0.27)
              : const Offset(0.39, 0.39),
        )
      ],
      child: Container(
        width: 353,
        height: 550,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(state.movableCard!.asset),
          ),
        ),
      ),
    );
  }

  void _endMove() {
    emit(LobbyState(
      isProfileAnimated: state.isProfileAnimated,
      movableCard: state.movableCard,
      isMoving: false
    ));
    Future.delayed(const Duration(milliseconds: 50), () {
      emit(LobbyState(
        isProfileAnimated: state.isProfileAnimated,
        movableCard: null
      ));
    });
  }


  void loadInfo(CardModel? card) {
    if (card != null) {
      emit(LobbyState(
        isProfileAnimated: state.isProfileAnimated,
        cardInfoFor: card
      ));
    } else {
      emit(LobbyState(
        isProfileAnimated: state.isProfileAnimated,
        cardInfoFor: null
      ));
    }
  }

  void setIsProfileAnimated(bool value) {
    if (state.isProfileAnimated == value) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => emit(LobbyState(
      isProfileAnimated: value,
      cardInfoFor: state.cardInfoFor,
      movableCard: state.movableCard,
      isMoving: state.isMoving
    )));
  }

  Widget waterFX() {
    if (state.isProfileAnimated) {
      return Stack(
        children: [
          wave(0),
          wave(2000)
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget wave(int delayValue) => Animate(
    delay: Duration(milliseconds: delayValue),
    onComplete: (controller) => controller.repeat(),
    effects: const [
      ScaleEffect(
        duration: Duration(milliseconds: 4000),
        begin: Offset(1, 1),
        end: Offset(1.2, 1.56),
      ),
      FadeEffect(
        curve: Curves.easeOutCubic,
        duration: Duration(milliseconds: 4000),
        begin: 1,
        end: 0,
      )
    ],
    child: Container(
      padding: const EdgeInsets.all(10),
      height: 270,
      width: 764,
      decoration: CustomDecorations.smoothLight(51),
      child: Container(decoration: CustomDecorations.smoothDark(41)),
    ),
  );

  //void _gotoRools() {;} TODO: запуск меню правил
}