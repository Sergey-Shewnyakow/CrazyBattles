import 'package:flutter/material.dart';
import 'game_models.dart'; // models of cards, game and players, cards data
import 'custom_colors.dart';//custom colors

class InfoCard extends StatefulWidget {
  final CardModel? card;
  final Function(CardModel?) close;

  const InfoCard({
    super.key,
    this.card,
    required this.close,
  });

  @override
  _infoCardState createState() => _infoCardState();
}

class _infoCardState extends State<InfoCard> {//TODO: animate

  @override
  Widget build(BuildContext context) {
    if (widget.card != null) {
      return Container(
        height: 1920,
        width: 1080,
        decoration: BoxDecoration(color: CustomColors.greyDark),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "../assets/rules/page_${widget.card!.infoPage}.png",
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 90,
                    width: 125,
                    color: CustomColors.greyInfo,
                  ),
                ),
              ]
            ),
            Positioned(
              top: 200,
              right: 0,
              child: IconButton(
                onPressed: () {
                  widget.close(null);
                },
                icon: const Icon(Icons.cancel, size: 80.0),
              ),  
            ),
          ],
        ),
      );
    }
    else {return const SizedBox.shrink();}
  }
}