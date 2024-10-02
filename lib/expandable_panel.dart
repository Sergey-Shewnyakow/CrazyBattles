import 'package:flutter/material.dart';

class ExpandablePanel extends StatefulWidget {
  final Widget background;
  final Widget title;
  final Widget? content;
  final Widget? addictionalBut;
  final double minH;//height
  final double maxH;
  final double minW;//width
  final double maxW;
  final double minY;//offset y
  final double maxY;
  final double minX;//offset x
  final double maxX;
  final double minTO;//title offset
  final double maxTO;
  final bool selfActivating;
  final Function? unload;
  
  const ExpandablePanel({
    super.key,
    required this.background,
    required this.title,
    this.content,
    this.minH = 115,
    this.maxH = 1200,
    this.minW = 290,
    this.maxW = 750,
    this.minY = 571,
    this.maxY = 1590,
    this.minX = 163,
    this.maxX = 610,
    this.minTO = 15,
    this.maxTO = 67.5,
    this.selfActivating = false,
    this.unload,
    this.addictionalBut,
  });

  @override
  _SomeExpandablePanelState createState() => selfActivating ? _AutoExpandablePanelState() : _ExpandablePanelState();
}

abstract class _SomeExpandablePanelState extends State<ExpandablePanel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
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

  Widget panel(EdgeInsetsGeometry padding, bool isExpanded) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        widget.background,
        Container(
          alignment: Alignment.topCenter,
          padding: padding,
          child: widget.title,
        ),
        if (isExpanded) widget.content ?? const SizedBox()
      ]
    );
  }
}

class _ExpandablePanelState extends _SomeExpandablePanelState {//for class choose panel
  bool _isExpanded = false;
  bool _isAnimEnded = false;

  @override
  Widget build(BuildContext context) {
    if (_isAnimEnded) {
      widget.unload!();
    }

    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = false;
              _controller.reverse().then((_) {
                setState(() {
                  _isAnimEnded = true;
                });
              });
            });
          },
          child: Container(decoration: const BoxDecoration()),
        ),
        widget.addictionalBut ?? const SizedBox.shrink(),
        GestureDetector(
          onTap: () {
            _isExpanded = true;
            _controller.forward();
            setState(() {
              _isAnimEnded = false;
            });
          },
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                height: widget.minH + _animation.value*(widget.maxH - widget.minH),
                width: widget.minW + _animation.value*(widget.maxW - widget.minW),
                margin: EdgeInsets.only(
                  top: widget.maxY + _animation.value*(widget.minY - widget.maxY),
                  left: widget.maxX + _animation.value*(widget.minX - widget.maxX)
                ),
                child: panel(EdgeInsets.only(top: widget.minTO + _animation.value*(widget.maxTO - widget.minTO)), _isExpanded),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AutoExpandablePanelState extends _SomeExpandablePanelState { // for card choose panel
  bool _isExpanded = true;
  bool _isAnimEnded = false;

  @override
  void initState() {
    super.initState();
    _controller.forward(); // Запускаем анимацию увеличения при создании
  }

  @override
  Widget build(BuildContext context) {
    if (_isAnimEnded) {
      widget.unload!();
      return const SizedBox.shrink();
    }

    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
              _controller.reverse().then((_) {
                setState(() {
                  _isAnimEnded = true;
                });
              });
            });
          },
          child: Container(decoration: const BoxDecoration()),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: widget.minH + _animation.value*(widget.maxH - widget.minH),
              width: widget.minW + _animation.value*(widget.maxW - widget.minW),
              margin: EdgeInsets.only(
                top: widget.maxY + _animation.value*(widget.minY - widget.maxY),
                left: widget.maxX + _animation.value*(widget.minX - widget.maxX)
              ),
              child: panel(EdgeInsets.only(top: widget.minTO + _animation.value*(widget.maxTO - widget.minTO)), _isExpanded),
            );
          },
        ),
      ]
    );
  }
}