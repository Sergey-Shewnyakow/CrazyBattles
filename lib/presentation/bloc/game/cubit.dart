import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '/style/custom_decorations.dart';
import '/style/custom_shadows.dart';
import '/style/custom_colors.dart';
import '/game_models/card_models.dart';
import '/game_models/player_model.dart';
import '../../widget/game_widgets/BLoC-less/card_widget.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:math';

Future<void> savePlayerData(
    String playerName, List<CharacterCardGameModel> cards) async {
  const String url = 'http://127.0.0.1:5000/save_player_data';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': playerName,
        'card_names':
            cards.map((card) => card.name).toList(), // Используем имя карты
      }),
    );

    if (response.statusCode == 200) {
      print("Карты игрока $playerName успешно сохранены: ${response.body}");
    } else {
      print(
          "Ошибка при сохранении карт игрока $playerName: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Ошибка при отправке карт игрока $playerName: $e");
  }
}

final random = Random();

class GameCubit extends Cubit<GameState> {
  bool isAttackPreparingStarted = false;

  GameCubit()
      : super(GameState(
            player1: PlayerModel(
                name: "НИКОПАВЕЛ",
                avatar: const AssetImage('images/missing_avatar1.jpg'),
                isOpponent: true,
                cards: CharacterCardGameModel.fromCardList([
                  characterCards[random.nextInt(27)],
                  characterCards[random.nextInt(27)],
                  characterCards[random.nextInt(27)],
                ], isMy: false)),
            player2: PlayerModel(
                name: "ВЫ",
                avatar: const AssetImage('images/missing_avatar.jpg'),
                isOpponent: false,
                cards: CharacterCardGameModel.fromCardList([
                  selectedCharacterCards[0],
                  selectedCharacterCards[1],
                  selectedCharacterCards[2]
                ], isMy: true)),
            someoneSkipped: false,
            gameEndState: -1)) {
    savePlayerData(state.player1.name, state.player1.cards);
  }

  static const int cardChangeDuration = 400;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      int time = state.time - 1;
      print(state.isChangingActive);
      if (state.gameEndState >= 0) {
        timer.cancel();
        return;
      }
      if (time == 0) {
        emit(GameState(
            player1: state.player1,
            player2: state.player2,
            myTurn: state.someoneSkipped ? state.myTurn : !state.myTurn,
            someoneSkipped: state.someoneSkipped,
            isChangingActive: state.isChangingActive,
            timerValue: '1:00',
            isAttacking: state.isAttacking && !state.myTurn,
            gameEndState: state.gameEndState));
        return;
      }
      emit(GameState(
          player1: state.player1,
          player2: state.player2,
          myTurn: state.myTurn,
          someoneSkipped: state.someoneSkipped,
          isChangingActive: state.isChangingActive,
          timerValue: '${time ~/ 60}:${time % 60 < 10 ? "0" : ""}${time % 60}',
          time: time,
          isAttacking: state.isAttacking,
          gameEndState: state.gameEndState));
    });
  }

  Widget buildProfile(bool isOpponent) {
    return Container(
        width: 435,
        height: 283,
        padding: const EdgeInsets.all(10),
        decoration: CustomDecorations.smoothColorableShadowDark(
            54,
            isOpponent != state.myTurn
                ? CustomColors.contrastBright
                : CustomColors.greyLight),
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: CustomDecorations.smoothDark(44),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 160,
                  height: 160,
                  padding: const EdgeInsets.all(11),
                  decoration: CustomDecorations.smoothMainShadowDark(41),
                  child: Container(
                      decoration: ShapeDecoration(
                          image: DecorationImage(
                              image: isOpponent
                                  ? state.player1.avatar
                                  : state.player2.avatar),
                          shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(
                                  cornerRadius: 30, cornerSmoothing: 1))))),
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child:
                      Text(isOpponent ? state.player1.name : state.player2.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          )))
            ])));
  }

  Widget cardsOrSlotsRow(bool isOpponent, List<Widget> cards) {
    // layout for cards
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            isOpponent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          cards[0],
          SizedBox(width: isOpponent ? 40 : 58),
          cards[1],
          SizedBox(width: isOpponent ? 58 : 40),
          cards[2]
        ]);
  }

  Widget buildPlayerCardsSlots(bool isOpponent) {
    return cardsOrSlotsRow(isOpponent, [
      CardWidget(isActive: !isOpponent),
      const CardWidget(),
      CardWidget(isActive: isOpponent)
    ]);
  }

  Widget buildPlayerCards(bool isOpponent) {
    return cardsOrSlotsRow(
        isOpponent,
        isOpponent
            ? [
                CardWidget(
                    card: state.player1.cards[2],
                    isVisible: state.isChangingActive == 0 || state.myTurn),
                CardWidget(
                    card: state.player1.cards[1],
                    isVisible: state.isChangingActive != 1 || state.myTurn),
                CardWidget(
                    card: state.player1.cards[0],
                    isActive: true,
                    isVisible: state.isChangingActive != 2 || state.myTurn)
              ]
            : [
                clickableCardWidget(state.player2.cards[0], isActive: true),
                clickableCardWidget(state.player2.cards[1]),
                clickableCardWidget(state.player2.cards[2])
              ]);
  }

  Widget clickableCardWidget(CharacterCardGameModel card,
      {bool isActive = false}) {
    CardWidget cardWidget = CardWidget(
        card: card,
        isActive: isActive,
        isVisible: state.isChangingActive == 0 ||
            state.isChangingActive == 3 - card.number ||
            !state.myTurn);
    if (!state.myTurn || state.isChangingActive != 0) return cardWidget;
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: isActive
                ? () => attackReady(true)
                : () => changeActiveCard(card.number),
            child: cardWidget));
  }

  Widget cardSwitcher() {
    if (state.isChangingActive == 0) return const SizedBox.shrink();
    return Animate(
        onInit: (controller) => controller.reset,
        onComplete: (controller) => changeActiveCardApply(),
        effects: [
          const Effect(
              duration: Duration(milliseconds: cardChangeDuration + 50)),
          CustomEffect(
              duration: const Duration(milliseconds: cardChangeDuration),
              builder: (_, value, child) => Stack(children: [
                    Positioned(
                        left: 139 +
                            value * (402 + 220 * (state.isChangingActive - 1)),
                        top: 947 + value * 283,
                        child: Container(
                            width: 180 + (165 * (1 - value)),
                            height: 283 + (255 * (1 - value)),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(state.player2
                                      .cards[state.isChangingActive].asset),
                                ),
                                boxShadow: CustomBoxShadows.shadowOnDark))),
                    Positioned(
                        left: 541 +
                            220 * (state.isChangingActive - 1) -
                            value * (402 + 220 * (state.isChangingActive - 1)),
                        top: 1230 - value * 283,
                        child: Container(
                            width: 180 + (165 * value),
                            height: 283 + (255 * value),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      state.player2.activeCard.asset),
                                ),
                                boxShadow: CustomBoxShadows.shadowOnDark)))
                  ]))
        ]);
  }

  Widget attacker() {
    if (!state.isAttacking) return const SizedBox.shrink();
    return Stack(children: [
      GestureDetector(
          onTapDown: (_) => isAttackPreparingStarted = true,
          onTap: () => {isAttackPreparingStarted = false, attackReady(false)},
          child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ))),
      Center(
          child: SizedBox(
              width: 810,
              height: 150,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _button("ATTACK", CustomColors.greyLight, attack),
                const SizedBox(width: 70),
                state.player2.activeCard.ultimateProgress == 4
                    ? _button("ULTIMATE", CustomColors.mainBright, ultimate)
                    : _inactiveButton()
              ])))
    ]);
  }

  Widget _button(String txt, Color color, Function func) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTapDown: (_) => isAttackPreparingStarted = true,
            onTap: () => {isAttackPreparingStarted = false, func()},
            child: Container(
                alignment: Alignment.center,
                height: 150,
                width: 370,
                decoration: CustomDecorations.smoothColorable(51, color),
                child: Text(txt,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 50)))));
  }

  Widget _inactiveButton() {
    return Container(
        alignment: Alignment.center,
        height: 150,
        width: 370,
        decoration:
            CustomDecorations.smoothColorable(51, CustomColors.greyDark),
        child: const Text("ULTIMATE",
            style: TextStyle(color: Colors.white, fontSize: 50)));
  }

  void changeActiveCard(int cardNum) {
    changeActiveCardAnimate(cardNum);
    changeActiveCardSend(cardNum);
  }

  Future<void> changeActiveCardSend(int cardNum) async {
    const url =
        'http://127.0.0.1:5000/update_active_card'; // Примерный URL, измените на свой

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'active_card_number': cardNum,
        }),
      );

      if (response.statusCode == 200) {
        print('Активная карта обновлена на сервере');
      } else {
        print('Ошибка обновления активной карты: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка при отправке данных на сервер: $e');
    }
  }

  void changeActiveCardAnimate(int cardNum) {
    if (state.player2.energy < 1) return;
    state.player2.energy--;
    state.player2.setActiveCard(number: cardNum);

    emit(GameState(
        player1: state.player1,
        player2: state.player2,
        myTurn: state.myTurn,
        someoneSkipped: state.someoneSkipped,
        isChangingActive: cardNum,
        timerValue: state.timerValue,
        time: state.time,
        gameEndState: state.gameEndState));
  }

  void changeActiveCardApply() {
    emit(GameState(
        player1: state.player1,
        player2: state.player2,
        myTurn: state.someoneSkipped ? state.myTurn : !state.myTurn,
        someoneSkipped: state.someoneSkipped,
        isChangingActive: 0,
        timerValue: state.timerValue,
        gameEndState: state.gameEndState));
  }

  void changeTurn() {
    if (!state.someoneSkipped) {
      emit(GameState(
          player1: state.player1,
          player2: state.player2,
          myTurn: !state.myTurn,
          someoneSkipped: true,
          timerValue: state.timerValue,
          gameEndState: state.gameEndState));
    } else {
      nextRound();
    }
  }

  void nextRound() {
    state.player1.resetEnergy();
    state.player2.resetEnergy();
    emit(GameState(
        player1: state.player1,
        player2: state.player2,
        myTurn: !state.myTurn,
        someoneSkipped: false,
        timerValue: state.timerValue,
        gameEndState: state.gameEndState));
    sendCardsHealthData();
  }

  void attackReady(bool value) {
    emit(GameState(
        player1: state.player1,
        player2: state.player2,
        myTurn: state.myTurn,
        someoneSkipped: state.someoneSkipped,
        isChangingActive: state.isChangingActive,
        timerValue: state.timerValue,
        time: state.time,
        isAttacking: value,
        gameEndState: state.gameEndState));
  }

  void attackDoneLetsChangeTurn() {
    emit(GameState(
        player1: state.player1,
        player2: state.player2,
        myTurn: !state.myTurn,
        someoneSkipped: state.someoneSkipped,
        timerValue: state.timerValue,
        gameEndState: state.gameEndState));
  }

  void attackPlayer(CharacterCardGameModel attackingCard,
      CharacterCardGameModel defendingCard) {
    int damage = 2;
    defendingCard.hp -= damage;

    if (defendingCard.hp <= 0) {
      print('${defendingCard.name} уничтожен!');
      changeOpponentActiveCard();
    } else {
      print(
          '${defendingCard.name} получил урон! Текущее здоровье: ${defendingCard.hp}');
    }

    attackingCard.ultimateProgress += 1;
    if (attackingCard.ultimateProgress >= 4.0) {
      attackingCard.ultimateProgress = 4.0;
      print('Ульта карты ${attackingCard.name} готова к использованию!');
    }

    // Обновляем состояние игры
    emit(GameState(
        player1: state.player1,
        player2: state.player2,
        myTurn: state.myTurn,
        someoneSkipped: state.someoneSkipped,
        isChangingActive: state.isChangingActive,
        timerValue: state.timerValue,
        time: state.time,
        isAttacking: state.isAttacking,
        gameEndState: state.gameEndState));
  }

  void checkOpponentCardsHealth() {
    List<CharacterCardGameModel> opponentCards = state.player1.cards;

    for (CharacterCardGameModel card in opponentCards) {
      if (card.hp <= 0) {
        print('Карта ${card.name} уничтожена!');
      } else {
        print('Карта ${card.name} здоровье: ${card.hp}');
      }
    }

    if (opponentCards.every((card) => card.hp <= 0)) {
      print('Все карты противника уничтожены! Вы победили!');
      emit(GameState(
          player1: state.player1,
          player2: state.player2,
          myTurn: state.myTurn,
          someoneSkipped: false,
          timerValue: "-:--",
          time: 0,
          isAttacking: false,
          gameEndState: 1 //Win/ if lose, zero
          ));
    }
  }

  void changeOpponentActiveCard() {
    if (state.player1.cards.where((card) => card.hp > 0).isEmpty) return;
    CharacterCardGameModel? nextActiveCard = state.player1.cards.firstWhere(
      (card) => card.hp > 0,
    );
    // Установить новую активную карту
    state.player1.setActiveCard(number: nextActiveCard.number);
    print('Активная карта противника изменена на ${nextActiveCard.name}');
  }

  Map<String, dynamic> collectCardsHealthData() {
    return {
      'player1': {
        'name': state.player1.name,
        'cards': state.player1.cards
            .map((card) => {
                  'name': card.name,
                  'hp': card.hp,
                })
            .toList(),
      },
      'player2': {
        'name': state.player2.name,
        'cards': state.player2.cards
            .map((card) => {
                  'name': card.name,
                  'hp': card.hp,
                })
            .toList(),
      },
    };
  }

  Future<void> sendCardsHealthData() async {
    const String url = 'http://127.0.0.1:5000/update_cards_health';

    Map<String, dynamic> data = collectCardsHealthData();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print("Данные о здоровье карт успешно отправлены: ${response.body}");
      } else {
        print(
            "Ошибка при отправке данных о здоровье карт: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Ошибка при отправке данных о здоровье карт: $e");
    }
  }

  void attack() {
    CharacterCardGameModel attackingCard =
        state.player2.activeCard; // карты атакующего
    if (state.player1.activeCard.hp > 0) {
      CharacterCardGameModel defendingCard = state.player1.activeCard;
      attackPlayer(attackingCard, defendingCard);
    } else if (state.player1.cards[1].hp > 0 &&
        state.player1.activeCard.hp <= 0) {
      CharacterCardGameModel defendingCard =
          state.player1.cards[1]; // карты защитника
      attackPlayer(attackingCard, defendingCard);
    } else if (state.player1.activeCard.hp <= 0 &&
        state.player1.activeCard.hp <= 0) {
      CharacterCardGameModel defendingCard =
          state.player1.cards[2]; // карты защитника
      attackPlayer(attackingCard, defendingCard);
    }

    applyRandomDamageToAlliedCard();

    checkOpponentCardsHealth();

    sendCardsHealthData();

    attackDoneLetsChangeTurn();
  }

  void ultimate() {
    // Получаем активную карту игрока
    CharacterCardGameModel activeCard = state.player2.activeCard;

    // Проверяем класс активной карты и применяем соответствующий эффект
    switch (activeCard.cardClass) {
      case "Саппорт":
        // +1 HP всем союзным картам и -1 HP всем вражеским картам
        for (var card in state.player2.cards) {
          card.hp += 1; // Увеличиваем здоровье союзных карт
        }
        for (var card in state.player1.cards) {
          card.hp -= 1; // Уменьшаем здоровье вражеских карт
          card.hp = card.hp < 0 ? 0 : card.hp; // Проверка на минимум
        }
        break;

      case "Дамаггер":
        // -2 HP всем вражеским картам
        for (var card in state.player1.cards) {
          card.hp -= 2;
          card.hp = card.hp < 0 ? 0 : card.hp; // Проверка на минимум
        }
        break;

      case "Хиллер":
        // +2 HP всем союзным картам
        for (var card in state.player2.cards) {
          card.hp += 2;
        }
        break;

      case "Щитовик":
        // -3 HP активной карте врага
        CharacterCardGameModel opponentActiveCard = state.player1.activeCard;
        opponentActiveCard.hp -= 2;
        opponentActiveCard.hp = opponentActiveCard.hp < 0
            ? 0
            : opponentActiveCard.hp; // Проверка на минимум
        break;

      default:
        print("Неизвестный класс карты: ${activeCard.cardClass}");
    }

    activeCard.ultimateProgress = 0;

    if (state.player1.activeCard.hp <= 0) {
      changeOpponentActiveCard();
    }

    // Проверяем состояние здоровья карт противника
    checkOpponentCardsHealth();

    // Отправляем обновленные данные на сервер
    sendCardsHealthData();

    // Завершаем ход
    attackDoneLetsChangeTurn();
  }

  void applyRandomDamageToAlliedCard() {
    // Выбираем случайную карту из списка союзных карт
    var card = state.player2.cards
        .where((card) => card.hp > 0) // Оставляем только карты с HP > 0
        .toList(); // Преобразуем результат в список

    if (card.isNotEmpty) {
      var randomCard = card[
          random.nextInt(card.length)]; // Выбираем случайную карту из списка
      int damage = random.nextInt(3) + 1; // Случайное значение от 1 до 3
      randomCard.hp -= damage;
      randomCard.hp = randomCard.hp < 0
          ? 0
          : randomCard.hp; // Убедитесь, что HP не уйдёт в минус
      print(
          '${randomCard.name} получил урон $damage HP. Текущее здоровье: ${randomCard.hp}');
    }

    // Проверяем, остались ли живые карты
    if (state.player2.cards.every((card) => card.hp <= 0)) {
      print('Все карты союзника уничтожены! Вы проиграли!');
    }
  }
}
