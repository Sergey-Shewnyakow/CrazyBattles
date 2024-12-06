import 'package:crazy_battles/main.dart';
import 'package:flutter/services.dart';

import '../bloc/game/cubit.dart';
import '../bloc/game/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart'; // flutter visual lib

import 'package:crazy_battles/style/custom_colors.dart';
import '../../style/custom_decorations.dart';
import '../widget/game_widgets/BLoC-less/game_end.dart';

class GameSession extends StatefulWidget {
  const GameSession({super.key});

  @override
  GameSessionState createState() => GameSessionState();
}

class GameSessionState extends State<GameSession> {
  final GameCubit cubit = GameCubit();
  bool isAttackPreparingStarted = false;
  Widget screenEnd = const SizedBox.shrink();

  @override
  void initState() {
    cubit.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ServicesBinding.instance.keyboard.addHandler(_onKey);
    return BlocBuilder<GameCubit, GameState>(
      bloc: cubit,
      builder: (context, state) {
        return Stack(
          children: [
            Center(
                child: SvgPicture.asset(
              "images/backgroundZ.svg",
              height: 535,
              fit: BoxFit.cover,
            )),
            Positioned(
                left: 150,
                top: 160,
                child: Container(
                    width: 290,
                    height: 160,
                    padding: const EdgeInsets.all(8),
                    decoration: CustomDecorations.smoothLightShadowDark(30),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: CustomDecorations.smoothDark(20),
                        child: Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('images/icoClock.svg'),
                                  const SizedBox(width: 10),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: Text(state.timerValue,
                                          style: TextStyle(
                                              color: CustomColors.greyLight,
                                              fontSize: 55)))
                                ]))))),
            Positioned(
                left: 77,
                top: 58,
                child: Container(
                    width: 435,
                    height: 148,
                    padding: const EdgeInsets.all(10),
                    decoration: CustomDecorations.smoothLightShadowDark(40),
                    child: Container(
                        //padding: const EdgeInsets.all(10),
                        decoration: CustomDecorations.smoothDark(30),
                        child: Stack(children: [
                          Positioned(
                              left: 45,
                              top: -20,
                              child: Text("*",
                                  style: TextStyle(
                                    color: CustomColors.mainBright,
                                    fontFamily: "monospace",
                                    fontSize: 140,
                                    fontWeight: FontWeight.w900,
                                  ))),
                          const SizedBox(width: 50),
                          const Positioned(
                              left: 125,
                              top: 8,
                              child: Text("1500",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 80,
                                  )))
                        ])))),
            Positioned(left: 550, top: 58, child: cubit.buildProfile(true)),
            Positioned(
              top: 400,
              left: 0,
              right: 0,
              child: cubit.buildPlayerCardsSlots(true),
            ),
            Positioned(
              top: 400,
              left: 0,
              right: 0,
              child: cubit.buildPlayerCards(true),
            ),
            // объявление об этапе/TODO: chooser of active card
            //if (state.game!.player1.activeCard == null)
            //  const Center(
            //    child: Text("Выберите активного персонажа", style: TextStyle(fontSize: 30, color: Colors.blue)),
            //  ),
            Positioned(
              bottom: 400,
              left: 0,
              right: 0,
              child: cubit.buildPlayerCardsSlots(false),
            ),
            cubit.cardSwitcher(),
            Positioned(
              bottom: 400,
              left: 0,
              right: 0,
              child: cubit.buildPlayerCards(false),
            ),
            Positioned(left: 90, top: 1580, child: cubit.buildProfile(false)),
            Positioned(
                left: 583,
                top: 1580,
                child: Container(
                    width: 230,
                    height: 135,
                    decoration: CustomDecorations.smoothMainShadowDark(32),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/lightning.svg',
                            height: 57,
                          ),
                          const SizedBox(width: 10),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("${state.player2.energy}",
                                  style: const TextStyle(
                                      fontSize: 55, color: Colors.white)))
                        ]))),
            Positioned(
                left: 825,
                top: 1580,
                child: Container(
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsets.only(right: 13),
                    width: 165,
                    height: 135,
                    decoration: CustomDecorations.smoothMainShadowDark(32),
                    child: Transform.rotate(
                        angle: -pi / 2,
                        child: const Text("*",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "monospace",
                              fontSize: 140,
                              fontWeight: FontWeight.w900,
                            ))))),
            Positioned(
                left: 583,
                top: 1734,
                child: MouseRegion(
                    cursor: state.myTurn
                        ? SystemMouseCursors.click
                        : SystemMouseCursors.basic,
                    child: GestureDetector(
                        onTap: () => {if (state.myTurn) cubit.changeTurn()},
                        child: Container(
                            width: 407,
                            height: 127,
                            decoration:
                                CustomDecorations.smoothLightShadowDark(36),
                            child: const Center(
                                child: Text("ЗАВЕРШИТЬ\nХОД",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white))))))),
            if(state.isAttacking)  Stack(
              children: [
                GestureDetector(
                  onTapDown: (_) => isAttackPreparingStarted = true,
                  onTap: () => {
                    isAttackPreparingStarted = false,
                    cubit.AttackReady(false)
                  },
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    )
                  )
                ),
                Center(
                  child: SizedBox(
                    width: 810,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _button("ATTACK", CustomColors.greyLight, cubit.attack),
                        const SizedBox(width: 70),
                        state.player2.activeCard.ultimateProgress == 4
                          ? _button("ULTIMATE", CustomColors.mainBright, cubit.ultimate)
                          : _inactiveButton()
                      ]
                    )
                  )
                )
              ]
            ),
            screenEnd
          ],
        );
      },
    );
  }

  Widget _button(String txt, Color color, Function func) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => isAttackPreparingStarted = true,
        onTap: () => {
          isAttackPreparingStarted = false,
          func()
        },
        child: Container(
          alignment: Alignment.center,
          height: 150,
          width: 370,
          decoration: CustomDecorations.smoothColorable(51, color),
          child: Text(
            txt,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 50
            )
          )
        )
      )
    );
  }

  Widget _inactiveButton() {
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: 370,
      decoration: CustomDecorations.smoothColorable(51, CustomColors.greyDark),
      child: const Text(
        "ULTIMATE",
        style: TextStyle(
          color: Colors.white,
          fontSize: 50
        )
      )
    );
  }

  bool _onKey(KeyEvent event) {
    final key = event.logicalKey.keyLabel;

    if (event is KeyUpEvent) {
      if (key == 'W') {
        screenEnd = const EndGameWidget(
          areYouWinningSon: true,
        );
      } else if (key == 'L') {
        screenEnd = const EndGameWidget(
          areYouWinningSon: false,
        );
      } else if (key == 'M') {
        CardGameApp.toMenu();
      }
    }

    return false;
  }
}
