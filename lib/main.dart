import 'package:flutter/material.dart'; // flutter visual lib
import 'package:flutter_animate/flutter_animate.dart'; // animations lib

import 'presentation/screen/screens.dart'; // all the screens of the app
import 'style/custom_colors.dart';

// Виджет игры
class CardGameApp extends StatefulWidget {
  static Function changeWindow = () => {};
  static Function toMenu = () => {};
  const CardGameApp({super.key});

  @override
  CardGameAppState createState() => CardGameAppState();
}

class CardGameAppState extends State<CardGameApp> {
  int inLobby = 0; // 0 = menu 1 = opponent search 2 = game screen
  int inLobbyPrev = 0;

  void _nextWindow() => setState(() {
        inLobby = (inLobby + 1) % 3;
      });
  void _toMenu() => setState(() {
        inLobby = 0;
      });

  @override
  void initState() {
    CardGameApp.changeWindow = _nextWindow;
    CardGameApp.toMenu = _toMenu;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'syncopate'),
        home: inLobby != inLobbyPrev
            ? animatedScreens()
            : Scaffold(
                backgroundColor: CustomColors.greyDark,
                body: Animate(
                    effects: const [
                      FadeEffect(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeOutCubic)
                    ],
                    child: Center(
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                                width: 1080,
                                height: 1920,
                                child: inLobby == 0
                                    ? const Lobby()
                                    : inLobby == 1
                                        ? const OpponentSearch()
                                        : const GameSession()))))));
  }

  Widget animatedScreens() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(color: CustomColors.greyDark),
        Animate(
          effects: const [
            ScaleEffect(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              begin: Offset(0, 0),
              end: Offset(2, 2),
            )
          ],
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColors.mainBright,
            ),
          ),
        ),
        Animate(
          onComplete: (controller) => setState(() {
            inLobbyPrev = inLobby;
          }),
          effects: const [
            ScaleEffect(
              delay: Duration(milliseconds: 200),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              begin: Offset(0, 0),
              end: Offset(2, 2),
            )
          ],
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColors.greyDark,
            ),
          ),
        ),
      ],
    );
  }
}

void main() => runApp(const CardGameApp());
