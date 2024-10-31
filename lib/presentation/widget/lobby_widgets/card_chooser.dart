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
import '../../../card_models.dart'; // models of cards, game and players, cards data

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
    if (widget.lobby.state.movableCard == null) cubit.setSlots();
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
                      if (i < (state.slots.length - 1)) const SizedBox(width: 26),
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
                  decoration: BoxDecoration(boxShadow: CustomBoxShadows.shadowOnDark),
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
                        ? () => CardGameApp.changeWindow()
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
          background: Container(decoration: CustomDecorations.smoothLightShadowDark(35)),
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
                          cubit.clickablePanelOfCardType(1,'Support'),
                          const SizedBox(width: 44),
                          cubit.clickablePanelOfCardType(2,'Damagger'),
                        ],
                      ),
                      const SizedBox(height: 44),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cubit.clickablePanelOfCardType(3,'Healer'),
                          const SizedBox(width: 44),
                          cubit.clickablePanelOfCardType(4,'Shielder'),
                        ],
                      ),
                      const SizedBox(height: 44),
                      cubit.clickablePanelOfCardType(5,""),//assist
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
