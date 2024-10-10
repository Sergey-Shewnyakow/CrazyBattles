import 'package:crazy_battles/opponent_search.dart';
import 'package:flutter/material.dart'; // flutter visual lib
import 'package:flutter_svg/flutter_svg.dart'; // svg lib
import 'package:flutter_animate/flutter_animate.dart'; // animations lib
import 'package:figma_squircle/figma_squircle.dart'; // package for rounded corners

import 'card_chooser.dart'; //logic of choosing cards and starting
import 'card_information_view.dart'; //for viewing info about card on click the info button
import 'custom_shadows.dart'; //custom box shadows
import 'game_models.dart'; // models of cards, game and players, cards data
import 'custom_colors.dart'; //custom colors

// Виджет игры
class CardGameApp extends StatefulWidget {
  static bool isCardMovingToSlot = false;
  const CardGameApp({super.key});

  @override
  CardGameAppState createState() => CardGameAppState();
}

class CardGameAppState extends State<CardGameApp> {
  GameModel? game;
  int inLobby = 0; // 0 = menu 1 = opponent search 2 = game screen
  int inLobbyPrev = 0;
  bool _isProfileAnimated = true;
  CardModel? cardInfoFor;
  CardModel? _movableCard;

  //void _gotoRools() {
  // TODO: запуск меню правил
  //}

  void _goToOpponentSearch() {
    setState(() {inLobby = 1;});
  }

  // Запуск игры с выбранными картами
  // TODO: выдача игрокам выбранных ими карт
  //void _startGame() {
  //  game = GameModel(
  //    player1: PlayerModel(name: "Игрок 1", cards: selectedCharacterCards + selectedAssistCards),
  //    player2: PlayerModel(name: "Игрок 2", cards: selectedCharacterCards + selectedAssistCards),
  //  );
  //  setState(() {
  //    inLobby = false;
  //  });
  //}

  void _loadInfo(CardModel? card) {
    if (card != null) {
      setState(() {
        cardInfoFor = card;
      });
    } else {
      setState(() {
        cardInfoFor = null;
      });
    }
  }

  void _moveCardToSlot(CardModel card) {
    setState(() {
      _movableCard = card;
    });
  }

  Widget _movingCard() {
    if (_movableCard == null) return const SizedBox.shrink();
    return Animate(
      onComplete: (controller) => setState(() {
        _movableCard = null;
        CardGameApp.isCardMovingToSlot = false;
      }),
      effects: [
        MoveEffect(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastEaseInToSlowEaseOut,
          begin: const Offset(360, 946),
          end: _movableCard!.isAssist
              ? Offset(selectedAssistCards.length == 1 ? 180 : 2450, 4327)
              : Offset(
                  selectedCharacterCards.length == 1
                      ? 493
                      : selectedCharacterCards.length == 2
                          ? 913
                          : 1333,
                  2905),
        ),
        ScaleEffect(
          duration: const Duration(milliseconds: 800),
          begin: const Offset(1, 1),
          end: _movableCard!.isAssist
              ? const Offset(0.27, 0.27)
              : const Offset(0.39, 0.39),
        )
      ],
      child: Container(
        width: 353,
        height: 550,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_movableCard!.asset),
          ),
        ),
      ),
    );
  }

  // TODO: выбор активной карты только для себя
  //void _selectActiveCard(PlayerModel player, CardModel card) {
  //  if (!card.isAssist && player == game!.player1) {
  //    game!.player1.activeCard = card;
  //    game!.player2.activeCard = card;
  //    setState(() {});
  //  }
  //}

  @override
  Widget build(BuildContext context) {
    Widget staticWidg = inLobby == 0
        ? _buildLobby()
        : inLobby == 1
            ? const OpponentSearch()
            : _gameScreen();
    return inLobby == inLobbyPrev ? staticWidg : animatedScreens();
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

  Widget _buildLobby() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'syncopate'),
      home: Animate(
        effects: const [
          FadeEffect(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
          )
        ],
        child: Scaffold(
          backgroundColor: CustomColors.greyDark,
          body: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 1080,
                height: 1920,
                child: Stack(
                  children: [
                    Container(
                      width: 1080,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 110,
                        vertical: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 124),
                          SizedBox(
                            height: 380,
                            width: 1080,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 315,
                                  width: 495,
                                  child: SvgPicture.asset(
                                      '../assets/images/logo.svg',
                                      fit: BoxFit.contain),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "БАЛДЕЖНЫЕ БИТВЫ",
                                    style: TextStyle(
                                      color: CustomColors.greyText,
                                      fontSize: 56.85,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 119),
                          Stack(
                            children: [
                              if (_isProfileAnimated) Stack(
                                children: [
                                  Animate(
                                    onComplete: (controller) => controller.repeat(),
                                    effects: const [
                                      ScaleEffect(
                                        duration: Duration(milliseconds: 4000),
                                        begin: Offset(1, 1),
                                        end: Offset(1.2, 1.56),
                                      ),
                                      FadeEffect(
                                        curve: Curves.easeOutCubic,
                                        duration: Duration(milliseconds: 4000),
                                        begin: 0.6,
                                        end: 0,
                                      )
                                    ],
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 270,
                                      width: 764,
                                      decoration: ShapeDecoration(
                                        color: CustomColors.greyLight,
                                        shape: SmoothRectangleBorder(
                                          borderRadius: SmoothBorderRadius(
                                            cornerRadius: 51,
                                            cornerSmoothing: 1,
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          color: CustomColors.greyDark,
                                          shape: SmoothRectangleBorder(
                                            borderRadius: SmoothBorderRadius(
                                              cornerRadius: 41,
                                              cornerSmoothing: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Animate(
                                    delay: const Duration(milliseconds: 2000),
                                    onComplete: (controller) => controller.repeat(),
                                    effects: const [
                                      ScaleEffect(
                                        duration: Duration(milliseconds: 4000),
                                        begin: Offset(1, 1),
                                        end: Offset(1.2, 1.56),
                                      ),
                                      FadeEffect(
                                        curve: Curves.easeOutCubic,
                                        duration: Duration(milliseconds: 4000),
                                        begin: 0.6,
                                        end: 0,
                                      )
                                    ],
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 270,
                                      width: 764,
                                      decoration: ShapeDecoration(
                                        color: CustomColors.greyLight,
                                        shape: SmoothRectangleBorder(
                                          borderRadius: SmoothBorderRadius(
                                            cornerRadius: 51,
                                            cornerSmoothing: 1,
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          color: CustomColors.greyDark,
                                          shape: SmoothRectangleBorder(
                                            borderRadius: SmoothBorderRadius(
                                              cornerRadius: 41,
                                              cornerSmoothing: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: ShapeDecoration(
                                  shadows: CustomBoxShadows.shadowOnDark,
                                  color: CustomColors.greyLight,
                                  shape: SmoothRectangleBorder(
                                    borderRadius: SmoothBorderRadius(
                                      cornerRadius: 41,
                                      cornerSmoothing: 1,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 25,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: CustomColors.greyDark,
                                    shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                        cornerRadius: 41,
                                        cornerSmoothing: 1,
                                      ),
                                    ),
                                  ),
                                  width: 743,
                                  child: Row(
                                    // TODO: account
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Container(
                                            width: 199,
                                            height: 199,
                                            padding: const EdgeInsets.all(16),
                                            decoration: ShapeDecoration(
                                              shadows:
                                                  CustomBoxShadows.shadowOnDark,
                                              color: CustomColors.mainBright,
                                              shape: SmoothRectangleBorder(
                                                borderRadius: SmoothBorderRadius(
                                                  cornerRadius: 51,
                                                  cornerSmoothing: 1,
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              decoration: ShapeDecoration(
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        '../assets/images/missing_avatar.jpg')),
                                                shape: SmoothRectangleBorder(
                                                  borderRadius: SmoothBorderRadius(
                                                    cornerRadius: 35,
                                                    cornerSmoothing: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 40),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "ВЛАД ЛАХТА",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 46.9,
                                            ),
                                          ),
                                          Text(
                                            "@lahta_vlad",
                                            style: TextStyle(
                                              color: CustomColors.greyText,
                                              fontSize: 31.15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 51),
                          Stack(
                              //rating
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                const Text(
                                  "РЕЙТИНГ:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 47.5,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "*",
                                      style: TextStyle(
                                        color: CustomColors.mainBright,
                                        fontFamily: "monospace",
                                        fontSize: 300,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(width: 50),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 50),
                                      child: Animate(
                                        onPlay: (controller) =>
                                            controller.repeat(),
                                        effects: [
                                          ShimmerEffect(
                                              color: CustomColors.mainBright,
                                              delay: const Duration(
                                                  milliseconds: 3000),
                                              duration: const Duration(
                                                  milliseconds: 2000))
                                        ],
                                        child: const Text(
                                          "1500",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 183.79,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                    CardChooser(
                      startOpponentSearch: _goToOpponentSearch,
                      animate: _moveCardToSlot,
                      loadInfo: _loadInfo,
                      onPanelActive: setIsProfileAnimated,
                    ),
                    InfoCard(card: cardInfoFor, close: _loadInfo),
                    _movingCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setIsProfileAnimated(bool value) {
    if (_isProfileAnimated == !value) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      _isProfileAnimated = !value;
    }));
  }

  // Виджет карты
  //TODO: change to smth that views card's visual
  //Widget _buildCardWidget(CardModel card, bool isSelected, Function(CardModel)? onTap) {
  //  return GestureDetector(
  //    onTap: () => onTap!(card),
  //    child: Container(
  //      padding: const EdgeInsets.all(8),
  //      decoration: BoxDecoration(
  //        border: Border.all(color: isSelected ? Colors.blue : Colors.grey), // Подсветка выбранной или активной карты
  //        borderRadius: BorderRadius.circular(8),
  //        color: isSelected ? Colors.blue.withOpacity(0.05) : null, // Дополнительная подсветка
  //      ),
  //      child: Column(
  //        mainAxisSize: MainAxisSize.min,
  //        children: [
  //          Text(card.name, style: const TextStyle(fontWeight: FontWeight.bold)),
  //          Text(card.cardClass, style: const TextStyle(fontStyle: FontStyle.italic)),
  //          if (!card.isAssist)
  //            Column(
  //              children: [
  //                Text("Навык: ${card.skill}"),
  //                Text("Ульта: ${card.ultimate}"),
  //                Text("Пассивка: ${card.passiveSkill}"),
  //              ],
  //            ),
  //        ],
  //      ),
  //    ),
  //  );
  //}

  //TODO: Добавить сам игровой процесс
  Widget _gameScreen() {
    return const Stack(
      children: [
        //      // Карты второго игрока
        //      Positioned(
        //        top: 20,
        //        left: 0,
        //        right: 0,
        //        child: _buildPlayerCards(game!.player2, _selectActiveCard),
        //      ),
        //      // объявление об этапе
        //      if (game!.player1.activeCard == null)
        //        const Center(
        //          child: Text("Выберите активного персонажа", style: TextStyle(fontSize: 30, color: Colors.blue)),
        //        ),
        //      // Карты первого игрока
        //      Positioned(
        //        bottom: 20,
        //        left: 0,
        //        right: 0,
        //        child: _buildPlayerCards(game!.player1, _selectActiveCard),
        //      ),
      ],
    );
  }

  //TODO: change according to design
  //Widget _buildPlayerCards(PlayerModel player, Function(PlayerModel, CardModel) onTap) {
  //  return Center(
  //    child: Wrap(
  //      spacing: 10,
  //      runSpacing: 10,
  //      children: [
  //        if (game!.player1.activeCard == null && player == game!.player1) // можно выбрать активную карту от лица 1-го игрока, если она еще не выбрана
  //          Wrap(children: player.cards.map((card) => _buildCardWidget(card, player.activeCard == card, (card) => onTap(player, card))).toList())
  //        else
  //          Wrap(children: player.cards.map((card) => _buildCardWidget(card, player.activeCard == card, null)).toList()),
  //      ],
  //    ),
  //  );
  //}
}

void main() => runApp(const CardGameApp());
