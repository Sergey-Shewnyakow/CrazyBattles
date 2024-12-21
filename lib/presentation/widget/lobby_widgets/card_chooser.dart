import '../../bloc/card_chooser/cubit.dart';
import '../../bloc/card_chooser/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart'; // package for rounded corners

import '../../../main.dart';
import '../../bloc/lobby/cubit.dart';
import '../../../style/custom_colors.dart';
import '../../../style/custom_shadows.dart';
import '../../../style/custom_decorations.dart';
import 'BLoC-less/expandable_panel.dart'; //panels that become huge on click
import '../../../game_models/card_models.dart'; // models of cards, game and players, cards data

import 'package:http/http.dart' as http;
import 'dart:convert'; // Для JSON

Future<void> submitSelectedCards(
  List<CardModel> selectedCharacterCards,
  List<CardModel> selectedAssistCards,
) async {
  const url = 'http://127.0.0.1:5000/submit_cards';
  try {
    print("Отправка запроса на $url...");
    print("Выбранные карты:");
    print(
        "Character: ${selectedCharacterCards.map((card) => card.name).toList()}");
    print("Assist: ${selectedAssistCards.map((card) => card.name).toList()}");

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'selected_character_cards':
            selectedCharacterCards.map((card) => card.name).toList(),
        'selected_assist_cards':
            selectedAssistCards.map((card) => card.name).toList(),
      }),
    );

    print("Ответ от сервера: ${response.statusCode}");
    if (response.statusCode == 200) {
      print("Карты успешно отправлены: ${response.body}");
    } else {
      print("Ошибка: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Ошибка при отправке данных: $e");
  }
}

class CardChooser extends StatefulWidget {
  final LobbyCubit lobby;
  final Function(CardModel) loadInfo;
  final Function(bool) onPanelActive;

  const CardChooser({
    super.key,
    required this.lobby,
    required this.loadInfo,
    required this.onPanelActive,
  });

  @override
  CardChooserState createState() => CardChooserState();
}

class CardChooserState extends State<CardChooser> {
  late final ChooserCubit cubit = ChooserCubit(widget);

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.lobby.state.isMoving) cubit.setSlots();
  }

  @override
  void initState() {
    cubit.setSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooserCubit, ChooserState>(
      bloc: cubit,
      builder: (context, state) {
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
          forcedActivating: state.forcedExpansion,
          addictionalBut: Stack(
            children: [
              Positioned(
                top: 1300,
                left: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 0; i < state.slots.length; i++) ...[
                      state.slots[i],
                      if (i < (state.slots.length - 1))
                        const SizedBox(width: 26),
                    ]
                  ],
                ),
              ),
              Positioned(
                left: 176,
                top: 1583.86,
                height: 130.81,
                width: 417.44,
                child: Container(
                  decoration:
                      BoxDecoration(boxShadow: CustomBoxShadows.shadowOnDark),
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
                    onPressed: selectedCharacterCards.length == 3
                        ? () {
                            submitSelectedCards(
                              selectedCharacterCards,
                              selectedAssistCards,
                            ); // Передача аргументов
                            CardGameApp.changeWindow();
                          }
                        : null,
                    child: Text(
                      "ИГРАТЬ",
                      style: TextStyle(
                        color: selectedCharacterCards.length == 3
                            ? Colors.white
                            : CustomColors.inactiveText,
                        fontSize: 57,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          unload: cubit.backToClassChoose,
          onActive: widget.onPanelActive,
          background: Container(
              decoration: CustomDecorations.smoothLightShadowDark(35)),
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
              cubit.clickablePanel(),
              FittedBox(
                child: cubit.clickablePanel(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cubit.clickablePanelOfCardType(1, 'Support'),
                          const SizedBox(width: 44),
                          cubit.clickablePanelOfCardType(2, 'Damagger'),
                        ],
                      ),
                      const SizedBox(height: 44),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cubit.clickablePanelOfCardType(3, 'Healer'),
                          const SizedBox(width: 44),
                          cubit.clickablePanelOfCardType(4, 'Shielder'),
                        ],
                      ),
                      const SizedBox(height: 44),
                      cubit.clickablePanelOfCardType(5, ""), //assist
                    ],
                  ),
                ),
              ),
              cubit.chooseExpandablePanel(),
            ],
          ),
        );
      },
    );
  }
}
