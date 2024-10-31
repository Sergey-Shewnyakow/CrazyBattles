import 'package:flutter/material.dart';
import '../../../../card_models.dart'; // models of cards, game and players, cards data
import '../../../../style/custom_colors.dart';//custom colors

class InfoCard extends StatefulWidget {
  final CardModel? card;
  final Function(CardModel?) close;

  const InfoCard({
    super.key,
    this.card,
    required this.close,
  });

  @override
  InfoCardState createState() => InfoCardState();
}

class InfoCardState extends State<InfoCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;
  bool _isClosing = false;// true when starts to close
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.card != null && !_isExpanded) {
      _controller.forward();
      setState(() {
        _isExpanded = true;
      });
    }
    else if (_isExpanded && _isClosing) {
      _controller.reverse().then((_) {
        setState(() {
          _isExpanded = false;
          _isClosing = false;
        });
        widget.close(null);
      });
    }
    else if (widget.card == null) {return const SizedBox.shrink();}
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Center (
          child: Container(
            height: _animation.value*1920,
            width: _animation.value*1080,
            decoration: BoxDecoration(color: CustomColors.greyDark),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "rules/page_${widget.card!.infoPage}.png",
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
                      setState(() {
                        _isClosing = true;
                      });
                    },
                    icon: const Icon(Icons.cancel, size: 80.0),
                  ),  
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}