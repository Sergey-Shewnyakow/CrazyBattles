import 'package:crazy_battles/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // svg lib
import 'package:figma_squircle/figma_squircle.dart'; // package for rounded corners

import 'bordered_square.dart'; //bordered square for class choose
import 'card_slot.dart';//slot for card in menu
import 'carousel.dart';//carousel for card choose implementation
import 'custom_colors.dart';//custom colors
import 'custom_shadows.dart'; //custom box shadows
import 'expandable_panel.dart';//panels that become huge on click
import 'game_models.dart'; // models of cards, game and players, cards data

class CardChooser extends StatefulWidget {
  final Function startOpponentSearch;
  final Function(CardModel) animate;
  final Function(CardModel) loadInfo;
  final bool isCardMovingToSlot;

  const CardChooser({
    super.key,
    required this.startOpponentSearch,
    required this.animate,
    required this.loadInfo,
    required this.isCardMovingToSlot,
  });

  @override
  CardChooserState createState() => CardChooserState();
}

class CardChooserState extends State<CardChooser> {
  int cardsSectionNum = 0;
  List<Slot> slots = [];
  int _forcedExpansion = 0;// 2 - forced expand, -2 - forced shrink

  void forceExpand(bool isAssist) {
    if (isAssist) {
      cardsSectionNum = 5;
    }
    setState(() {
      _forcedExpansion = 2;
    });
  }

  void backToClassChoose() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      setState(() {cardsSectionNum = 0;})
    );
  }

  // Выбор карт персонажей
  void _selectCharacterCard(CardModel card) {
    if (selectedCharacterCards.contains(card)) {// removing card
      selectedCharacterCards.remove(card);
      CardGameApp.isCardMovingToSlot = false;
      _reloadCharacterCards();
    } else if (selectedCharacterCards.length < 3) {// adding card
      selectedCharacterCards.add(card);
      if  (!CardGameApp.isCardMovingToSlot) _reloadCharacterCards();
      _forcedExpansion = -2;
      cardsSectionNum = 0;
      widget.animate(card);
    }
    else {return;}
    setState(() {});
  }

  void _reloadCharacterCards() {
    for (int i = 0; i < 3; i++) {
      slots[i+1] = Slot(
        isAssist: false,
        slotNumber: i,
        reload: _selectCharacterCard,
        openTheChooser: forceExpand,
      );//slots[1,2,3]
    }
  }

  // Выбор карт подмоги
  void _selectAssistCard(CardModel card) {
    if (selectedAssistCards.contains(card)) {// removing card
      selectedAssistCards.remove(card);
      CardGameApp.isCardMovingToSlot = false;
      _reloadAssistCards();
    } else if (selectedAssistCards.length < 2) {// adding card
      selectedAssistCards.add(card);
      if  (!CardGameApp.isCardMovingToSlot) _reloadAssistCards();
      _forcedExpansion = -2;
      cardsSectionNum = 0;
      widget.animate(card);
    }
    else {return;}
    setState(() {});
  }

  void _reloadAssistCards() {
    for (int i = 0; i < 2; i++) {
      slots[i*4] = Slot(
        isAssist: true,
        slotNumber: i,
        reload: _selectAssistCard,
        openTheChooser: forceExpand
      );//slots[0 & 4]
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isCardMovingToSlot) {
      _reloadCharacterCards();
      _reloadAssistCards();
    }
  }

  @override
  void initState() {
    slots = [
      Slot(isAssist: true, slotNumber: 0, reload: _selectAssistCard, openTheChooser: forceExpand),
      Slot(isAssist: false, slotNumber: 0, reload: _selectCharacterCard, openTheChooser: forceExpand),
      Slot(isAssist: false, slotNumber: 1, reload: _selectCharacterCard, openTheChooser: forceExpand),
      Slot(isAssist: false, slotNumber: 2, reload: _selectCharacterCard, openTheChooser: forceExpand),
      Slot(isAssist: true, slotNumber: 1, reload: _selectAssistCard, openTheChooser: forceExpand),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  if (_forcedExpansion > 0) {
    _forcedExpansion--;
  }
  else if (_forcedExpansion < 0) {
    _forcedExpansion++;
  }
  return ExpandablePanel(
      minH: 115, 
      minW: 290,
      maxH: 1200,
      maxW: 760,
      minY: 571,
      minX: 160,
      maxY: 1590,
      maxX: 610,
      minTO: 15,
      maxTO: 67.5,
      selfActivating: false,
      forcedActivating: _forcedExpansion,
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
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 35,
                      cornerSmoothing: 1,
                    ),
                  ),
                  elevation: 2,
                  padding: EdgeInsets.zero,
                ),
                onPressed: selectedCharacterCards.length == 3 ? () => widget.startOpponentSearch() : null,
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
        decoration: ShapeDecoration(
          shadows: CustomBoxShadows.shadowOnDark,
          color: CustomColors.greyLight,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 35,
              cornerSmoothing: 1,
            ),
          ),
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
              minH: 250,
              minW: 250,
              maxH: 792,
              maxW: 544,
              minY: 215,
              minX: 104,
              maxY: 215,
              maxX: 104,
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
                info: widget.loadInfo,
              ),
            )
          : cardsSectionNum == 2 ?
            ExpandablePanel (
              minH: 250,
              minW: 250,
              maxH: 792,
              maxW: 544,
              minY: 215,
              minX: 104,
              maxY: 215,
              maxX: 396,
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
                info: widget.loadInfo,
              ),
            )
          : cardsSectionNum == 3 ?
            ExpandablePanel (
              minH: 250,
              minW: 250,
              maxH: 792,
              maxW: 544,
              minY: 215,
              minX: 104,
              maxY: 509,
              maxX: 104,
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
                info: widget.loadInfo,
              ),
            )
          : cardsSectionNum == 4 ?
            ExpandablePanel (
              minH: 250,
              minW: 250,
              maxH: 792,
              maxW: 544,
              minY: 215,
              minX: 104,
              maxY: 509,
              maxX: 396,
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
                info: widget.loadInfo,
              ),
            )
          : cardsSectionNum == 5 ?
            ExpandablePanel (
              minH: 180,
              minW: 544,
              maxH: 792,
              maxW: 544,
              minY: 215,
              minX: 104,
              maxY: 804,
              maxX: 104,
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
                info: widget.loadInfo,
              ),
            )
          : const SizedBox(),
        ]
      ),
    );
  }
}