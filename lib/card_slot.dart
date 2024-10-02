import 'package:crazy_battles/custom_shadows.dart';
import 'package:flutter/material.dart'; // flutter visual lib
import 'game_models.dart'; // models of cards, game and players, cards data
import 'custom_colors.dart';//custom colors

class Slot extends StatefulWidget {
  final bool isAssist;
  final int slotNumber;
  final Function(CardModel) reload;

  const Slot({
    super.key, 
    required this.isAssist,
    required this.slotNumber,
    required this.reload,
  });

  @override
  _SlotState createState() => _SlotState();
}

class _SlotState extends State<Slot> {
  double _radius = 0;
  double _width = 0;
  double _height = 0;
  CardModel? _card;
  
  @override
  void initState() {
    _radius = widget.isAssist ? 4.59 : 6.82;
    _width = widget.isAssist ? 93.27 : 138.77;
    _height = widget.isAssist ? 144.94 : 215.64;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _card =
      (widget.isAssist && selectedAssistCards.length > widget.slotNumber) ?
        selectedAssistCards[widget.slotNumber]
      : (!widget.isAssist && selectedCharacterCards.length > widget.slotNumber) ? 
        selectedCharacterCards[widget.slotNumber]
      : null;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (_card != null) {
            CardModel card = _card!;
            if (widget.isAssist) {
              widget.reload(card);
            } else {
              widget.reload(card);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_radius),
            color: CustomColors.cardSlot,
            boxShadow: CustomBoxShadows.shadowOnDark,
          ),
          height: _height,
          width: _width,
          child: (_card != null) ? Image.asset(_card!.asset) : null,
        ),
      ),
    );
  }
}

void doNothing(CardModel card) {}
