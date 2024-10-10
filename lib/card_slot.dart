import 'dart:async';
import 'custom_shadows.dart';
import 'package:flutter/material.dart'; // flutter visual lib
import 'package:flutter_animate/flutter_animate.dart';
import 'game_models.dart'; // models of cards, game and players, cards data
import 'custom_colors.dart';//custom colors

class Slot extends StatefulWidget {
  final bool isAssist;
  final int slotNumber;
  final Function(CardModel) reload;
  final Function(bool) openTheChooser;

  const Slot({
    super.key, 
    required this.isAssist,
    required this.slotNumber,
    required this.reload,
    required this.openTheChooser,
  });

  @override
  SlotState createState() => SlotState();
}

class SlotState extends State<Slot> with SingleTickerProviderStateMixin {
  double _radius = 0;
  double _width = 0;
  double _height = 0;
  CardModel? _card;
  late AnimationController _controller;
  Timer? timer;

  @override
  void initState() {
    _radius = widget.isAssist ? 4.59 : 6.82;
    _width = widget.isAssist ? 93.27 : 138.77;
    _height = widget.isAssist ? 144.94 : 215.64;
    _controller = AnimationController(vsync: this);
    timer = Timer.periodic(const Duration(seconds: 8), (timer) => _tryToShake());
    super.initState();
  }
  
  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _tryToShake() {
    if (!widget.isAssist && selectedCharacterCards.length == widget.slotNumber) {setState(() {
      _controller.forward().then((void f) => _controller.value = 0);
    });}
  }

  @override
  Widget build(BuildContext context) {
    _card =
      (widget.isAssist && selectedAssistCards.length > widget.slotNumber) ?
        selectedAssistCards[widget.slotNumber]
      : (!widget.isAssist && selectedCharacterCards.length > widget.slotNumber) ? 
        selectedCharacterCards[widget.slotNumber]
      : null;
    return Animate(
      autoPlay: false,
      controller: _controller,
      effects: const [
        ShakeEffect(
          duration: Duration(
            milliseconds: 600),
          hz: 9,
          offset: Offset(3, 0)
        )
      ],
      child: MouseRegion(
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
            else {
              widget.openTheChooser(widget.isAssist);
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
      ),
    );
  }
}
