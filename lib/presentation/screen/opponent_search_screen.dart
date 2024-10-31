import '../bloc/opponent_search/cubit.dart';
import '../bloc/opponent_search/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart'; // flutter visual lib
import 'package:flutter_svg/flutter_svg.dart'; // svg lib
import 'package:flutter_animate/flutter_animate.dart'; // animations lib
import 'package:loading_animation_widget/loading_animation_widget.dart'; // beautiful loading animations lib

import 'package:crazy_battles/style/custom_decorations.dart';
import '../../style/custom_colors.dart';

class OpponentSearch extends StatefulWidget {
  const OpponentSearch({super.key});

  @override
  MyOpponentSearchState createState() => MyOpponentSearchState();
}

class MyOpponentSearchState extends State<OpponentSearch> {
  late final OpponentSearchCubit cubit = OpponentSearchCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpponentSearchCubit, OpponentSearchState>(
      bloc: cubit,
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Animate(
              onPlay: cubit.startTimer,
              effects: const [
                MoveEffect(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  begin: Offset(0, -150),
                  end: Offset(0, 0),
                )
              ],
              child: Positioned(
                top: 560,
                child: Container(
                  width: 400,
                  height: 160,
                  padding: const EdgeInsets.all(8),
                  decoration: CustomDecorations.smoothLightShadowDark(30),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: CustomDecorations.smoothDark(20),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('images/icoClock.svg'),
                          const SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Text(
                              state.timeStopwatch,
                              style: TextStyle(
                                  color: CustomColors.greyLight,
                                  fontSize: 60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                width: 778,
                height: 384,
                padding: const EdgeInsets.all(10),
                decoration: CustomDecorations.smoothLightShadowDark(54),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: CustomDecorations.smoothDark(44),
                  child: Padding(
                    padding: const EdgeInsets.all(75),
                    child: SizedBox(
                      child: SvgPicture.asset('images/logo.svg'),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 940,
              child: LoadingAnimationWidget.stretchedDots(
                color: CustomColors.mainBright,
                size: 200,
              ),
            ),
            Positioned(
              top: 1350,
              child: Animate(
                onPlay: (controller) => controller.repeat(),
                effects: [
                  ShimmerEffect(
                      color: CustomColors.mainBright,
                      delay: const Duration(milliseconds: 1000),
                      duration: const Duration(milliseconds: 2000))
                ],
                child: const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "ПОИСК\nСОПЕРНИКА",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 0.85,
                      color: Colors.white,
                      fontSize: 100,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}