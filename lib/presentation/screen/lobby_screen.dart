import '../bloc/lobby/cubit.dart';
import '../bloc/lobby/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart'; // flutter visual lib
import 'package:flutter_svg/flutter_svg.dart'; // svg lib
import 'package:flutter_animate/flutter_animate.dart'; // animations lib
import 'package:figma_squircle/figma_squircle.dart'; // package for rounded corners

import '../../style/custom_colors.dart';
import '../../style/custom_decorations.dart';
import '../widget/lobby_widgets/card_chooser.dart'; //logic of choosing cards and starting
import '../widget/lobby_widgets/BLoC-less/card_information_view.dart'; //for viewing info about card on click the info button

class Lobby extends StatefulWidget {
  const Lobby({super.key});

  @override
  MyLobbyState createState() => MyLobbyState();
}

class MyLobbyState extends State<Lobby> {
  final LobbyCubit cubit = LobbyCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LobbyCubit, LobbyState>(
      bloc: cubit,
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              width: 1080,
              padding: const EdgeInsets.symmetric(
                horizontal: 110,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 124),
                  SizedBox(
                    height: 380,
                    width: 1080,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 315,
                          width: 495,
                          child: SvgPicture.asset('images/logo.svg'),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "БАЛДЕЖНЫЕ БИТВЫ",
                            style: TextStyle(
                              color: CustomColors.greyText,
                              fontSize: 56.85,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 119),
                  Stack(
                    children: [
                      cubit.waterFX(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: CustomDecorations.smoothLightShadowDark(41),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 25,
                          ),
                          decoration: CustomDecorations.smoothDark(41),
                          width: 743,
                          child: Row(
                            // TODO: account
                            children: [
                              Container(
                                width: 199,
                                height: 199,
                                padding: const EdgeInsets.all(16),
                                decoration: CustomDecorations.smoothMainShadowDark(51),
                                child: Container(
                                  decoration: ShapeDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('images/missing_avatar.jpg')
                                    ),
                                    shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                        cornerRadius: 35,
                                        cornerSmoothing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "ВЛАД ЛАХТА",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 46.9,
                                    ),
                                  ),
                                  Text(
                                    "@lahta_vlad",
                                    style: TextStyle(
                                      color: CustomColors.greyText,
                                      fontSize: 31.15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 51),
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      const Text(
                        "РЕЙТИНГ:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 47.5,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "*",
                            style: TextStyle(
                              color: CustomColors.mainBright,
                              fontFamily: "monospace",
                              fontSize: 300,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 50),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 50),
                            child: Animate(
                              onPlay: (controller) =>
                                  controller.repeat(),
                              effects: [
                                ShimmerEffect(
                                    color: CustomColors.mainBright,
                                    delay: const Duration(
                                        milliseconds: 3000),
                                    duration: const Duration(
                                        milliseconds: 2000))
                              ],
                              child: const Text(
                                "1500",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 183.79,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                ],
              ),
            ),
            CardChooser(
              lobby: cubit,
              loadInfo: cubit.loadInfo,
              onPanelActive: cubit.setIsProfileAnimated,
            ),
            InfoCard(card: state.cardInfoFor, close: cubit.loadInfo),
            cubit.movingCard(),
          ],
        );
      },
    );
  }
}