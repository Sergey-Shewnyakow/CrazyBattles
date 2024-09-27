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
  // ignore: no_logic_in_create_state
  State<ExpandablePanel> createState() => selfActivating ? _AutoExpandablePanelState() : _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel> {//for class choose panel
  bool _isExpanded = false;
  double _height = 0;
  double _width = 0;
  double offsetY = -1;
  double offsetX = -1;
  double titleOffset = -1;

  void setExpand(bool value) {
    _isExpanded = value;
    _height = _isExpanded ? widget.maxH : widget.minH;
    _width = _isExpanded ? widget.maxW : widget.minW;
    offsetY = _isExpanded ? widget.minY : widget.maxY;
    offsetX = _isExpanded ? widget.minX : widget.maxX;
    titleOffset = _isExpanded ? widget.maxTO : widget.minTO;
  }

  @override
  Widget build(BuildContext context) {
    if (_height == 0) _height = widget.minH;
    if (_width == 0) _width = widget.minW;
    if (offsetY == -1) offsetY = widget.maxY;
    if (offsetX == -1) offsetX = widget.maxX;
    if (titleOffset == -1) titleOffset = widget.minTO;

    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              setExpand(false);
              widget.unload!();
            });
          },
          child: _isExpanded ? Container(
            decoration: const BoxDecoration(),
          ) : null,
        ),
        widget.addictionalBut ?? SizedBox.shrink(),
        GestureDetector(
          onTap: () {
            setState(() {
              setExpand(true);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _height,
            width: _width,
            margin: EdgeInsets.only(top: offsetY, left: offsetX),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                widget.background,
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: titleOffset),
                  child: widget.title,
                ),
                if (_isExpanded)
                  widget.content ?? const SizedBox()
              ]
            ),
          ),
        )
      ],
    );
  }
}

class _AutoExpandablePanelState extends State<ExpandablePanel> with SingleTickerProviderStateMixin { // for card choose panel
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isExpanded = true;
  bool _isAnimEnded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1.0).animate(_controller);
    _controller.forward(); // Запускаем анимацию увеличения при создании
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  widget.background,
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: widget.minTO + _animation.value*(widget.maxTO - widget.minTO)),
                    child: widget.title,
                  ),
                  if (_isExpanded)
                    widget.content ?? const SizedBox()
                ]
              ),
            );
          },
        ),
      ]
    );
  }
}