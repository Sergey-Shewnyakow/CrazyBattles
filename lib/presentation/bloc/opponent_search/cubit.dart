import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'dart:async'; // async lib

import '../../../main.dart';

class OpponentSearchCubit extends Cubit<OpponentSearchState> {
  OpponentSearchCubit() : super(OpponentSearchState(timeStart: DateTime.now()));

  void startTimer(AnimationController _) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      int timeNow = DateTime.now().difference(state.timeStart).inSeconds.toInt();
      if (timeNow > 3) {
        CardGameApp.changeWindow();
        timer.cancel();
        return;
      }
      emit(OpponentSearchState(
        timeStart: state.timeStart,
        timeStopwatch: "${timeNow ~/ 60}:${timeNow % 60 < 10 ? "0" : ""}${timeNow % 60}",
        isTimerStarted: true
      ));
    });
  }
}