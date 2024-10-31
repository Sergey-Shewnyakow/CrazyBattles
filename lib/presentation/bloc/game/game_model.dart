import '../../../card_models.dart';

// Модель игрока
class PlayerModel {
  String name;
  List<CardModel> cards;
  int energy;
  CardModel? activeCard;

  PlayerModel({
    required this.name,
    required this.cards,
    this.activeCard,
    this.energy = 8,
  });

  void resetEnergy() => energy = 8;
}

// Модель игры
class GameModel {
  PlayerModel player1;
  PlayerModel player2;
  bool player1Turn = true;
  int round = 1;

  GameModel({
    required this.player1,
    required this.player2,
  });

  void nextTurn() => player1Turn = !player1Turn;

  void nextRound() {
    round++;
    player1.resetEnergy();
    player2.resetEnergy();
  }

  void endGame() {} // Завершение игры
}