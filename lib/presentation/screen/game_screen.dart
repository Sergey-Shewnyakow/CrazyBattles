import '../bloc/game/cubit.dart';
import '../bloc/game/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart'; // flutter visual lib

import 'package:crazy_battles/style/custom_colors.dart';

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
                color: CustomColors.mainBright,// TODO: WHY TF SHOULD I USE IT???
                height: 535,
                fit: BoxFit.cover,
              )
            ),
            //TODO: Добавить сам игровой процесс
            // Container(color: Colors.amberAccent)
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
          ],
        );
      },
    );
  }
}