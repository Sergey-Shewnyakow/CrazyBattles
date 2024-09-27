import 'package:flutter/material.dart';
import 'game_models.dart'; // models of cards, game and players, cards data

class CardsComplect extends StatefulWidget {
  final CardModel? card;

  const CardsComplect({
    super.key,
    required this.card,//TODO animate
  });

  @override
  _CardsComplectState createState() => _CardsComplectState();
}

class _CardsComplectState extends State<CardsComplect> {
  final List<String> characterAssets = selectedCharacterCards.map((card) => card.asset).toList(); // Список адресов изображений выбранных карт персонажа
  final List<String> assistAssets = selectedAssistCards.map((card) => card.asset).toList(); // Список адресов изображений выбранных карт подмоги
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children:[
        if (selectedAssistCards.isNotEmpty)
          AssistCard(185, selectedAssistCards[0].asset),
        if (selectedCharacterCards.isNotEmpty)
          CharacterCard(305, selectedCharacterCards[0].asset),
        if (selectedCharacterCards.length > 1)
          CharacterCard(470, selectedCharacterCards[1].asset),
        if (selectedCharacterCards.length > 2)
          CharacterCard(635, selectedCharacterCards[2].asset),
        if (selectedAssistCards.length > 1)
          AssistCard(800, selectedAssistCards[1].asset)
      ],
    );
  }

  Widget CharacterCard(double x, String asset) {
    return Positioned(
      top: 1303,
      width: 141,
      left: x,
      child: Image.asset(
        asset,
      ),
    );
  }

  Widget AssistCard(double x, String asset) {
    return Positioned(
      top: 1375,
      left: x,
      child: Image.asset(
        width: 94,
        asset,
      ),
    );
  }
}