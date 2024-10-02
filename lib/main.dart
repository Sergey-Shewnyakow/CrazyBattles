import 'package:flutter/material.dart'; // flutter visual lib
import 'dart:async'; // async lib
import 'package:flutter_svg/flutter_svg.dart'; // svg lib
import 'package:flutter_animate/flutter_animate.dart'; // animations lib
import 'package:loading_animation_widget/loading_animation_widget.dart'; // beautiful loading animations lib
import 'package:figma_squircle/figma_squircle.dart'; // package for rounded corners

import 'card_information_view.dart'; //for viewing info about card on click the info button
import 'bordered_square.dart'; //bordered square for class choose
import 'custom_shadows.dart'; //custom box shadows
import 'game_models.dart'; // models of cards, game and players, cards data
import 'carousel.dart';//carousel for card choose implementation
import 'expandable_panel.dart';//panels that become huge on click
import 'custom_colors.dart';//custom colors
import 'card_slot.dart';//slot for card in menu

// Виджет игры
class CardGameApp extends StatefulWidget {
  @override
  _CardGameAppState createState() => _CardGameAppState();
}

class _CardGameAppState extends State<CardGameApp> {
  GameModel? game;
  int inLobby = 0; // 0 = menu 1 = opponent search 2 = game screen
  int cardsSectionNum = 0;
  CardModel? cardInfoFor;
  DateTime _timeStart = DateTime.now();
  String _timeStopwatch= "";
  bool _isTimerStarted = false;
  List<Slot> slots = [];

  //void _gotoRools() {
  // TODO: запуск меню правил
  //}

  void _goToOpponentSearch() {
    _timeStart = DateTime.now();
    _isTimerStarted = false;
    setState(() {inLobby = 1;});
  }

  @override
  void initState() {
    slots = [
      Slot(isAssist: true, slotNumber: 0, reload: _selectAssistCard),
      Slot(isAssist: false, slotNumber: 0, reload: _selectCharacterCard),
      Slot(isAssist: false, slotNumber: 1, reload: _selectCharacterCard),
      Slot(isAssist: false, slotNumber: 2, reload: _selectCharacterCard),
      Slot(isAssist: true, slotNumber: 1, reload: _selectAssistCard),
    ];
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        int timeNow = DateTime.now().difference(_timeStart).inSeconds.toInt();
        setState(() {
          _timeStopwatch = "${timeNow ~/ 60}:${timeNow % 60 < 10 ? "0" : ""}${timeNow % 60}";
        });
      }
    );
    super.initState();
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
      setState(() {cardInfoFor = card;});
    }
    else {
      setState(() {cardInfoFor = null;});
    }
  }

  // Выбор карт персонажей
  void _selectCharacterCard(CardModel card) {
    if (selectedCharacterCards.contains(card)) {// removing card
      selectedCharacterCards.remove(card);
      _reloadCharacterCards();
      setState(() {});
    } else if (selectedCharacterCards.length < 3) {// adding card
      selectedCharacterCards.add(card);
      _reloadCharacterCards();
      setState(() {});
    }
  }

  void _reloadCharacterCards() {
    for (int i = 0; i < 3; i++) {
      slots[i+1] = Slot(isAssist: false, slotNumber: i, reload: _selectCharacterCard);//slots[1,2,3]
    }
  }

  // Выбор карт подмоги
  void _selectAssistCard(CardModel card) {// removing card

    if (selectedAssistCards.contains(card)) {
      selectedAssistCards.remove(card);
      _reloadAssistCards();
      setState(() {});
    } else if (selectedAssistCards.length < 2) {// adding card
      selectedAssistCards.add(card);
      _reloadAssistCards();
      setState(() {});
    }
  }

  void _reloadAssistCards() {
    for (int i = 0; i < 2; i++) {
      slots[i*4] = Slot(isAssist: true, slotNumber: i, reload: _selectAssistCard);//slots[0 & 4]
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
              child: inLobby==0 ? _buildLobby() : inLobby==1 ? _opponentSearch() : _gameScreen(),
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
                child: Row( // TODO: account
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
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
            ],
          ),
        ),
        SizedBox(
          height: 1920,
          width: 1080,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ExpandablePanel(
                addictionalBut: Stack(
                  children: [
                    Positioned(
                      top: 1300,
                      left: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          slots[0],
                          const SizedBox(width: 26),
                          slots[1],
                          const SizedBox(width: 26),
                          slots[2],
                          const SizedBox(width: 26),
                          slots[3],
                          const SizedBox(width: 26),
                          slots[4],
                        ],
                      ),
                    ),
                    Positioned(
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
                          onPressed: selectedCharacterCards.length == 3 ? _goToOpponentSearch : null,
                          child: Text(
                            "ИГРАТЬ",
                            style: TextStyle(
                              color: selectedCharacterCards.length == 3 ? Colors.white : CustomColors.inactiveText,
                              fontSize: 57
                            )
                          )
                        ),
                      ),
                    ),
                  ],
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
                                  child: BorderedSquare(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
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
                                  child: BorderedSquare(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
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
                                  child: BorderedSquare(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
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
                                  child: BorderedSquare(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
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
                              child: const BorderedSquare(
                                height: 180,
                                width: 544,
                                radius: 6,
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
                        background: const BorderedSquare(radius: 6),
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
                        background: const BorderedSquare(radius: 6),
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
                        background: const BorderedSquare(radius: 6),
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
                        background: const BorderedSquare(radius: 6),
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
                        background: const BorderedSquare(radius: 6),
                        title: const Text(
                          "ПОДМОГА",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30
                          ),
                        ),
                        content: ImageCarousel(
                          imageAssets: assistCards.map((card) => card.asset).toList(),
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

  Widget _opponentSearch() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Animate(
          onPlay: (controller) => _isTimerStarted = true,
          effects: const [MoveEffect(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            begin: Offset(0, -150),
            end: Offset(0, 0),
          )],
          child: Positioned(
            top: 560,
            child:Container(
              width: 400,
              height: 160,
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                shadows: CustomBoxShadows.shadowOnDark,
                color: CustomColors.greyLight,
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 30,
                    cornerSmoothing: 1,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: CustomColors.greyDark,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left:20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        '../assets/images/icoClock.svg',
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(width: 20),

                      Padding(
                        padding: const EdgeInsets.only(top:7),
                        child: Text(
                          _isTimerStarted ? _timeStopwatch : "0:00",
                          style: TextStyle(
                            color: CustomColors.greyLight,
                            fontSize: 60
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 200,
          child:Container(
            width: 778,
            height: 384,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              shadows: CustomBoxShadows.shadowOnDark,
              color: CustomColors.greyLight,
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 54,
                  cornerSmoothing: 1,
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: CustomColors.greyDark,
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 44,
                    cornerSmoothing: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(75),
                child: SizedBox(
                  child: SvgPicture.asset(
                    '../assets/images/logo.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 940,
          child: LoadingAnimationWidget.stretchedDots(
            color: CustomColors.mainBright, 
            size: 200,
          ),
        ),
        Positioned(
          top: 1350,
          child: Animate(
            onPlay: (controller) => controller.repeat(),
            effects: [ShimmerEffect(color: CustomColors.mainBright,
                                    delay: const Duration(milliseconds: 1000),
                                    duration: const Duration(milliseconds: 2000))],
            child: const Padding(
              padding:  EdgeInsets.only(top: 10),
              child:  Text(
                "ПОИСК\nСОПЕРНИКА",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 0.85,
                  color: Colors.white,
                  fontSize: 100,
                ),
              ),
            ),
          ),
        ),
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

void main() => runApp(CardGameApp());
