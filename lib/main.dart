import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'card_information_view.dart'; //for viewing info about card on click the info button
import 'card_socket.dart'; //bordered socket for card in menu
import 'custom_shadows.dart'; //custom box shadows
import 'game_models.dart'; // models of cards, game and players, cards data
import 'cards_complect.dart'; //selected cards stack implementation in menu
import 'carousel.dart';//carousel for card choose implementation
import 'extendable_panel.dart';//panels that become huge on click
import 'custom_colors.dart';//custom colors

// Виджет игры
class CardGameApp extends StatefulWidget {
  @override
  _CardGameAppState createState() => _CardGameAppState();
}

class _CardGameAppState extends State<CardGameApp> {
  GameModel? game;
  bool inLobby = true;
  int cardsSectionNum = 0;
  CardModel? newCard;
  CardModel? cardInfoFor;

  //void _gotoRools() {
    // TODO: запуск меню правил
  //}

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
      setState(() {cardInfoFor = card;});
    }
    else {
      setState(() {cardInfoFor = null;});
    }
  }

  // Выбор карт персонажей
  void _selectCharacterCard(CardModel card) {
    if (selectedCharacterCards.contains(card)) {
      selectedCharacterCards.remove(card);
      setState(() {});
    } else if (selectedCharacterCards.length < 3) {
      selectedCharacterCards.add(card);
      setState(() {newCard = card;});
    }
  }

  // Выбор карт подмоги
  void _selectAssistCard(CardModel card) {
    if (selectedAssistCards.contains(card)) {
      selectedAssistCards.remove(card);
      setState(() {});
    } else if (selectedAssistCards.length < 2) {
      selectedAssistCards.add(card);
      setState(() {newCard = card;});
    }
  }

  // TODO: выбор активной карты только для себя
  //void _selectActiveCard(PlayerModel player, CardModel card) {
  //  if (!card.isAssist && player == game!.player1) {
  //    game!.player1.activeCard = card;
  //    game!.player2.activeCard = card;
  //    setState(() {});
  //  }
  //}

  void backToClassChoose() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      setState(() {cardsSectionNum = 0;})
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'syncopate'),
      home: Scaffold(
        backgroundColor: CustomColors.greyDark,
        body: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: 1080,
              height: 1920,
              child: inLobby ? _buildLobby() : _buildGame(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLobby() {
    return Stack(
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
                        fit: BoxFit.contain
                      ),
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
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.greyDark,
                      borderRadius: BorderRadius.circular(51),
                      border: Border.all(
                        color: CustomColors.greyLight,
                        width: 10,
                      ),
                      boxShadow: CustomBoxShadows.shadowOnDark
                    ),
                    width: 743,
                    child: Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Image.asset(
                              '../assets/images/missing_avatar.jpg',
                              width: 167.2,
                              height: 167.2,
                            ),
                            Container(
                              width: 199,
                              height: 199,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                  color: CustomColors.mainBright,
                                  width: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 51),
              Stack(//rating
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
                      Icon(
                        Icons.star_rate,
                        color: CustomColors.mainBright,
                        size: 183.79,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          "1500",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 183.79,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
              ),
              const SizedBox(height: 18),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BorderedSocket(radius: 4.59, height: 144.94, width: 93.27),
                  SizedBox(width: 26),
                  BorderedSocket(radius: 6.82, height: 215.64, width: 138.77),
                  SizedBox(width: 26),
                  BorderedSocket(radius: 6.82, height: 215.64, width: 138.77),
                  SizedBox(width: 26),
                  BorderedSocket(radius: 6.82, height: 215.64, width: 138.77),
                  SizedBox(width: 26),
                  BorderedSocket(radius: 4.59, height: 144.94, width: 93.27),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 1920,
          width: 1080,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CardsComplect(card: newCard),
              ExpandablePanel(
                addictionalBut: Positioned(
                  left: 176,
                  top: 1583.86,
                  height: 130.81,
                  width: 417.44,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: CustomBoxShadows.shadowOnDark
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.mainBright,
                        disabledBackgroundColor: CustomColors.greyLight,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        shadowColor: CustomColors.darkShadowMain,
                        elevation: 2,
                        padding: EdgeInsets.zero,
                      ),
                      //TODO: сделать коммент кодом вместо null, когда будет готова функция начала игры
                      onPressed: null,//selectedCharacterCards.length == 3 ? _startGame : null,
                      child: Text(
                        "ИГРАТЬ",
                        style: TextStyle(
                          color: selectedCharacterCards.length == 3 ? Colors.white : CustomColors.inactiveText,
                          fontSize: 57
                        )
                      )
                    )
                  ),
                ),
                unload: backToClassChoose,
                background: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.greyLight,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: CustomBoxShadows.shadowOnDark
                  ),
                ),
                title: const Text(
                  "ИЗМЕНИТЬ\nСОСТАВ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                content: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          cardsSectionNum = 0;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(),
                      ),
                    ),
                    FittedBox(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            cardsSectionNum = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardsSectionNum = 1;
                                    });
                                  },
                                  child: BorderedSocket(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
                                    isBackBright: true,
                                    child: SvgPicture.asset(
                                      '../assets/images/icoSupport.svg',
                                      fit: BoxFit.contain
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 44,),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardsSectionNum = 2;
                                    });
                                  },
                                  child: BorderedSocket(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
                                    isBackBright: true,
                                    child: SvgPicture.asset(
                                      '../assets/images/icoDamagger.svg',
                                      fit: BoxFit.contain
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 44),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardsSectionNum = 3;
                                    });
                                  },
                                  child: BorderedSocket(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
                                    isBackBright: true,
                                    child: SvgPicture.asset(
                                      '../assets/images/icoHealer.svg',
                                      fit: BoxFit.contain
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 44,),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardsSectionNum = 4;
                                    });
                                  },
                                  child: BorderedSocket(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
                                    isBackBright: true,
                                    child: SvgPicture.asset(
                                      '../assets/images/icoShielder.svg',
                                      fit: BoxFit.contain
                                    ),
                                  ),
                                ),
                              ]
                            ),
                            const SizedBox(height: 44),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  cardsSectionNum = 5;
                                });
                              },
                              child: const BorderedSocket(
                                height: 180,
                                width: 544,
                                radius: 6,
                                isBackBright: true,
                                child: Text(
                                  "ПОДМОГА",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                    cardsSectionNum == 1 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 215,
                        minX: 104,
                        maxX: 104,
                        minH: 250,
                        maxH: 792,
                        minW: 250,
                        maxW: 544,
                        minTO: 90,
                        maxTO: 50,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: SvgPicture.asset(
                          '../assets/images/icoSupport.svg',
                          fit: BoxFit.contain
                        ),
                        content: ImageCarousel(
                          imageAssets: characterCards.sublist((cardsSectionNum-1)*7, cardsSectionNum*7).map((card) => card.asset).toList(),
                          sectionNumber: cardsSectionNum-1,
                          pick: _selectCharacterCard,
                          info: _loadInfo,
                        ),
                      )
                    : cardsSectionNum == 2 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 215,
                        minX: 104,
                        maxX: 396,
                        minH: 250,
                        maxH: 792,
                        minW: 250,
                        maxW: 544,
                        minTO: 90,
                        maxTO: 50,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: SvgPicture.asset(
                          '../assets/images/icoDamagger.svg',
                          fit: BoxFit.contain
                        ),
                        content: ImageCarousel(
                          imageAssets: characterCards.sublist((cardsSectionNum-1)*7, cardsSectionNum*7).map((card) => card.asset).toList(),
                          sectionNumber: cardsSectionNum-1,
                          pick: _selectCharacterCard,
                          info: _loadInfo,
                        ),
                      )
                    : cardsSectionNum == 3 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 509,
                        minX: 104,
                        maxX: 104,
                        minH: 250,
                        maxH: 792,
                        minW: 250,
                        maxW: 544,
                        minTO: 90,
                        maxTO: 50,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: SvgPicture.asset(
                          '../assets/images/icoHealer.svg',
                          fit: BoxFit.contain
                        ),
                        content: ImageCarousel(
                          imageAssets: characterCards.sublist((cardsSectionNum-1)*7, cardsSectionNum*7).map((card) => card.asset).toList(),
                          sectionNumber: cardsSectionNum-1,
                          pick: _selectCharacterCard,
                          info: _loadInfo,
                        ),
                      )
                    : cardsSectionNum == 4 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 509,
                        minX: 104,
                        maxX: 396,
                        minH: 250,
                        maxH: 792,
                        minW: 250,
                        maxW: 544,
                        minTO: 80,
                        maxTO: 40,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: SvgPicture.asset(
                          '../assets/images/icoShielder.svg',
                          fit: BoxFit.contain
                        ),
                        content: ImageCarousel(
                          imageAssets: characterCards.sublist((cardsSectionNum-1)*7, cardsSectionNum*7).map((card) => card.asset).toList(),
                          sectionNumber: cardsSectionNum-1,
                          pick: _selectCharacterCard,
                          info: _loadInfo,
                        ),
                      )
                    : cardsSectionNum == 5 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 804,
                        minX: 104,
                        maxX: 104,
                        minH: 180,
                        maxH: 792,
                        minW: 544,
                        maxW: 544,
                        minTO: 75,
                        maxTO: 50,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: const Text(
                          "ПОДМОГА",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30
                          ),
                        ),
                        content: ImageCarousel(
                          imageAssets: AssistCards.map((card) => card.asset).toList(),
                          sectionNumber: cardsSectionNum-1,
                          pick: _selectAssistCard,
                          info: _loadInfo,
                        ),
                      )
                    : const SizedBox(),
                  ]
                ),
              ),
            ],
          ),
        ),
        InfoCard(card: cardInfoFor, close: _loadInfo,),
      ],
    );
  }

  // Виджет карты
  //TODO: change to sth that views card's visual
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
  Widget _buildGame() {
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

void main() => runApp(CardGameApp());
