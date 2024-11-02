import '../../../card_models.dart'; // models of cards, game and players, cards data

class LobbyState {
  final bool isProfileAnimated;
  final CardModel? cardInfoFor;
  final CardModel? movableCard;
  final bool isMoving;

  const LobbyState({
    required this.isProfileAnimated,
    this.cardInfoFor,
    this.movableCard,
    this.isMoving = false
  });
}