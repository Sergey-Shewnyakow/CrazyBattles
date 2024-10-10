import 'package:flutter/material.dart'; // flutter visual lib
import 'dart:async'; // async lib
import 'package:flutter_svg/flutter_svg.dart'; // svg lib
import 'package:flutter_animate/flutter_animate.dart'; // animations lib
import 'package:loading_animation_widget/loading_animation_widget.dart'; // beautiful loading animations lib
import 'package:figma_squircle/figma_squircle.dart'; // package for rounded corners

import 'custom_shadows.dart'; //custom box shadows
import 'custom_colors.dart'; //custom colors

class OpponentSearch extends StatefulWidget {
  const OpponentSearch({
    super.key,
  });

  @override
  OpponentSearchState createState() => OpponentSearchState();
}

class OpponentSearchState extends State<OpponentSearch> {
  DateTime _timeStart = DateTime.now();
  String _timeStopwatch = "";
  bool _isTimerStarted = false;

  @override
  void initState() {
    _isTimerStarted = false;
    _timeStart = DateTime.now();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      int timeNow = DateTime.now().difference(_timeStart).inSeconds.toInt();
      setState(() {
        _timeStopwatch = "${timeNow ~/ 60}:${timeNow % 60 < 10 ? "0" : ""}${timeNow % 60}";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'syncopate'),
      home: Scaffold(
        backgroundColor: CustomColors.greyDark,
        body: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: 1080,
              height: 1920,
              child: Animate(
                effects: const [
                  FadeEffect(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeOutCubic,
                  )
                ],
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Animate(
                      onPlay: (controller) => _isTimerStarted = true,
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
                          decoration: ShapeDecoration(
                            shadows: CustomBoxShadows.shadowOnDark,
                            color: CustomColors.greyLight,
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(
                                cornerRadius: 30,
                                cornerSmoothing: 1,
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: CustomColors.greyDark,
                              shape: SmoothRectangleBorder(
                                borderRadius: SmoothBorderRadius(
                                  cornerRadius: 20,
                                  cornerSmoothing: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    '../assets/images/icoClock.svg',
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Text(
                                      _isTimerStarted ? _timeStopwatch : "0:00",
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
                        decoration: ShapeDecoration(
                          shadows: CustomBoxShadows.shadowOnDark,
                          color: CustomColors.greyLight,
                          shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: 54,
                              cornerSmoothing: 1,
                            ),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            color: CustomColors.greyDark,
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(
                                cornerRadius: 44,
                                cornerSmoothing: 1,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(75),
                            child: SizedBox(
                              child: SvgPicture.asset(
                                '../assets/images/logo.svg',
                                fit: BoxFit.contain,
                              ),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}