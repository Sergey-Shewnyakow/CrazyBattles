import 'state.dart';
import 'statics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../../widget/lobby_widgets/card_chooser.dart';
import '../../../style/custom_decorations.dart';
import '../../widget/lobby_widgets/BLoC-less/card_slot.dart'; //slot for card in menu
import '../../widget/lobby_widgets/BLoC-less/expandable_panel.dart'; //panels that become huge on click
import '../../widget/lobby_widgets/BLoC-less/carousel.dart'; //carousel for card choose implementation
import '../../../game_models/card_models.dart'; // models of cards, game and players, cards data

class ChooserCubit extends Cubit<ChooserState> {
  ChooserCubit(CardChooser widget) : super(ChooserState(
    cardsSectionNum: 0,
    slots: const [],
    forcedExpansion: 0,
    thisWidget: widget,
  ));

  void setState({int? cardsSectionNum, List<Slot>? slots, int? forcedExpansion}) {
    emit(ChooserState(
      cardsSectionNum: cardsSectionNum ?? state.cardsSectionNum,
      slots: slots ?? state.slots,
      forcedExpansion: forcedExpansion ?? 0,
      thisWidget: state.thisWidget,
    ));
  }

  void forceExpand(bool isAssist) => setState(
    cardsSectionNum: isAssist ? 5 : state.cardsSectionNum,
    forcedExpansion: 1,
  );

  void backToClassChoose() => setState(cardsSectionNum: 0);

  // Выбор карт персонажей
  void _selectCharacterCard(CardModel card) {
    if (selectedCharacterCards.contains(card)) {
      // removing card
      selectedCharacterCards.remove(card);
      setState(slots: slotsWithReloadedCharacterCards());
    } else if (selectedCharacterCards.length < 3) {
      // adding card
      selectedCharacterCards.add(card);
      setState(
        cardsSectionNum: 0,
        slots: state.slots,
        forcedExpansion: -1,
      );
      state.thisWidget.lobby.moveCardToSlot(card);
    }
  }

  List<Slot> slotsWithReloadedCharacterCards() {
    List<Slot> slots = state.slots;
    for (int i = 0; i < 3; i++) {
      slots[i + 1] = Slot(
        isAssist: false,
        slotNumber: i,
        reload: _selectCharacterCard,
        openTheChooser: forceExpand,
      ); //slots[1,2,3]
    }
    return slots;
  }

  // Выбор карт подмоги
  void _selectAssistCard(CardModel card) {
    if (selectedAssistCards.contains(card)) {
      // removing card
      selectedAssistCards.remove(card);
      setState(slots: slotsWithReloadedAssistCards());
    } else if (selectedAssistCards.length < 2) {
      // adding card
      selectedAssistCards.add(card);
      setState(
        cardsSectionNum: 0,
        slots: state.slots,
        forcedExpansion: -1,
      );
      state.thisWidget.lobby.moveCardToSlot(card);
    }
  }

  List<Slot> slotsWithReloadedAssistCards() {
    List<Slot> slots = state.slots;
    for (int i = 0; i < 2; i++) {
      slots[i * 4] = Slot(
          isAssist: true,
          slotNumber: i,
          reload: _selectAssistCard,
          openTheChooser: forceExpand); //slots[0 & 4]
    }
    return slots;
  }

  void setSlots() {setState(slots: _slots);}
  
  List<Slot> get _slots => [
    Slot(
        isAssist: true,
        slotNumber: 0,
        reload: _selectAssistCard,
        openTheChooser: forceExpand
    ),
    Slot(
        isAssist: false,
        slotNumber: 0,
        reload: _selectCharacterCard,
        openTheChooser: forceExpand
    ),
    Slot(
        isAssist: false,
        slotNumber: 1,
        reload: _selectCharacterCard,
        openTheChooser: forceExpand
    ),
    Slot(
        isAssist: false,
        slotNumber: 2,
        reload: _selectCharacterCard,
        openTheChooser: forceExpand
    ),
    Slot(
        isAssist: true,
        slotNumber: 1,
        reload: _selectAssistCard,
        openTheChooser: forceExpand
    ),
  ];

  Widget clickablePanelOfCardType(int number, String title_) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: clickablePanel(
        numberSetOnClick: number,
        child: Container(
          height: number < 5 ? Layout.characterPanelWidthOrHeight : Layout.assistPanelWidth,
          width: number < 5 ? Layout.characterPanelWidthOrHeight : Layout.assistPanelHeight,
          alignment: Alignment.center,
          decoration: CustomDecorations.smoothDarkShadowDark(35),
          child: number < 5 ? Titles.characterTitle(title_) : Titles.assistTitle,
        ),
      ),
    );
  }

  Widget chooseExpandablePanel() {
    return switch (state.cardsSectionNum) {
      1 => expandablePanelForChoose('Support'),
      2 => expandablePanelForChoose('Damagger'),
      3 => expandablePanelForChoose('Healer'),
      4 => expandablePanelForChoose('Shielder'),
      5 => expandablePanelForChoose("ПОДМОГА"),
      _ => const SizedBox(),
    };
  }

  

  Widget clickablePanel({int? numberSetOnClick, Widget? child}) {
    numberSetOnClick ??= 0;
    child ??= Container(decoration: const BoxDecoration());
    return GestureDetector(
      onTap: () {
        setState(cardsSectionNum: numberSetOnClick!);
      },
      child: child,
    );
  }

  Widget expandablePanelForChoose(String title_) {
    return ExpandablePanel(
      minH: state.cardsSectionNum < 5 ? Layout.characterPanelWidthOrHeight : Layout.assistPanelWidth,
      minW: state.cardsSectionNum < 5 ? Layout.characterPanelWidthOrHeight : Layout.assistPanelHeight,
      maxH: 792,
      maxW: 555,
      minY: 215,
      minX: 104,
      maxY: state.cardsSectionNum < 3 ? Layout.firstRowY
        : state.cardsSectionNum < 5 ? Layout.secondRowY
          : Layout.thirdRowY,
      maxX: state.cardsSectionNum % 2 == 1 ? Layout.firstColumnX : Layout.secondColumnX,
      minTO: state.cardsSectionNum < 5 ? Layout.characterTitleTopOffset : Layout.assistTitleTopOffset,
      maxTO: 50,
      selfActivating: true,
      unload: backToClassChoose,
      background: Container(decoration: CustomDecorations.smoothDarkShadowDark(35)),
      title: state.cardsSectionNum < 5 ? Titles.characterTitle(title_) : Titles.assistTitle,
      content: CardCarousel(
        imageAssets: state.cardsSectionNum < 5 ?
          characterCards
            .sublist((state.cardsSectionNum - 1) * 7, state.cardsSectionNum * 7)
            .map((card) => card.asset)
            .toList()
          : assistCards
            .map((card) => card.asset)
            .toList(),
        sectionNumber: state.cardsSectionNum - 1,
        pick: state.cardsSectionNum < 5 ? _selectCharacterCard : _selectAssistCard,
        info: state.thisWidget.loadInfo,
      ),
    );
  }
}