import 'package:flutter/material.dart';

import 'card_models.dart';

// Модель игрока
class PlayerModel {
  String name;
  ImageProvider avatar;
  bool isOpponent;
  List<CharacterCardGameModel> cards;
  int energy;

  PlayerModel({
    required this.name,
    required this.avatar,
    required this.isOpponent,
    required this.cards,
    this.energy = 8,
  });

  CharacterCardGameModel get activeCard => cards[0];

  void resetEnergy() => energy = 8;

  void setActiveCard({required int number}) {
    cards = [
      cards[number],
      cards[number == 1 ? 0 : 1],
      cards[number == 2 ? 0 : 2]
    ];
    for (int i = 0; i < 3; i++) {
      cards[i].number = i;
    }
    cards[0].isActive = true;
    cards[number].isActive = false;
  }
}

class CharacterCardGameModel extends CardModel {
  int hp;
  double ultimateProgress;
  bool isActive;
  bool isMy;
  int number;

  CharacterCardGameModel(
      {required super.name,
      required super.asset,
      required super.cardClass,
      required super.infoPage,
      required this.isMy,
      required this.number,
      this.hp = 10,
      this.ultimateProgress = 0,
      this.isActive = false});

  static List<CharacterCardGameModel> fromCardList(List<CardModel> cards,
      {required bool isMy}) {
    List<CharacterCardGameModel> list = [];
    for (int i = 0; i < 3; i++) {
      CardModel card = cards[i];
      CharacterCardGameModel cardInGame = CharacterCardGameModel(
          name: card.name,
          asset: card.asset,
          cardClass: card.cardClass,
          infoPage: card.infoPage,
          isMy: isMy,
          number: i,
          hp: 10,
          ultimateProgress: 0.0);
      if (i == 0) cardInGame.isActive = true;
      list.add(cardInGame);
    }
    return list;
  }
}
