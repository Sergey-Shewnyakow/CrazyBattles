import '../bloc/game/cubit.dart';
import '../bloc/game/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart'; // flutter visual lib

import 'package:crazy_battles/style/custom_colors.dart';
import '../../style/custom_decorations.dart';

class GameSession extends StatefulWidget {
  const GameSession({super.key});

  @override
  GameSessionState createState() => GameSessionState();
}

class GameSessionState extends State<GameSession> {
  final GameCubit cubit = GameCubit();

  @override
  Widget build(BuildContext context) {
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
              )
            ),
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
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "1:00",
                            style: TextStyle(
                              color: CustomColors.greyLight,
                              fontSize: 60
                            )
                          )
                        )
                      ]
                    )
                  )
                )
              )
            ),
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
                  child: Stack(
                    children: [
                      Positioned(
                        left: 45,
                        top: -20,
                        child: Text(
                          "*",
                          style: TextStyle(
                            color: CustomColors.mainBright,
                            fontFamily: "monospace",
                            fontSize: 140,
                            fontWeight: FontWeight.w900,
                          )
                        )
                      ),
                      const SizedBox(width: 50),
                      const Positioned(
                        left: 125,
                        top: 8,
                        child: Text(
                          "1500",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                          )
                        )
                      )
                    ]
                  )
                )
              )
            ),
            Positioned(
              left: 550,
              top: 58,
              child: cubit.buildProfile(true)
            ),
            //Карты второго игрока
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
            // Карты первого игрока
            Positioned(
              bottom: 400,
              left: 0,
              right: 0,
              child: cubit.buildPlayerCards(false),
            ),
            Positioned(
              left: 90,
              top: 1580,
              child: cubit.buildProfile(false)
            )
          ],
        );
      },
    );
  }
}