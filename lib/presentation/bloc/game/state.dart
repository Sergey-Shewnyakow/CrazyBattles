import '../../../game_models/player_model.dart';

class GameState {
  final PlayerModel player1;
  final PlayerModel player2;
  final bool myTurn;
  final bool someoneSkipped;
  final int isChangingActive;
  final String timerValue;
  final int time;
  final bool isAttacking;
  final int gameEndState;

  GameState(
      {required this.player1,
      required this.player2,
      this.time = 3,
      this.myTurn = true,
      this.isChangingActive = 0,
      this.timerValue = "0:03",
      required this.someoneSkipped,
      this.isAttacking = false,
      required this.gameEndState});
}
