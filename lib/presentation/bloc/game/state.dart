import 'game_model.dart';

class GameState {
  final PlayerModel player1;
  final PlayerModel player2;
  final bool myTurn;
  final int isChangingActive;
  final String timerValue;
  final int time;

  GameState({
    required this.player1,
    required this.player2,
    this.time = 60,
    this.myTurn = true,
    this.isChangingActive = 0,
    this.timerValue = "1:00",
  });
}

  //void nextTurn() => player1Turn = !player1Turn;

  //void nextRound() {
  //  player1.resetEnergy();
  //  player2.resetEnergy();
  //}