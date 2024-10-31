import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // animations lib

class ExpandablePanel extends StatefulWidget {
  final Widget background;
  final Widget title;
  final Widget content;
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
  final int forcedActivating;//activating (1) or deactivating (-1) by something else
  final Function? unload;
  final Function(bool)? onActive;
  
  const ExpandablePanel({
    super.key,
    required this.background,
    required this.title,
    required this.content,
    required this.minH, 
    required this.minW,
    required this.maxH,
    required this.maxW,
    required this.minY,
    required this.minX,
    required this.maxY,
    required this.maxX,
    required this.minTO,
    required this.maxTO,
    required this.selfActivating,
    this.forcedActivating = 0,
    this.unload,
    this.onActive,
    this.addictionalBut,
  });

  @override
  SomeExpandablePanelState createState() => selfActivating ? AutoExpandablePanelState() : ExpandablePanelState();
}

abstract class SomeExpandablePanelState extends State<ExpandablePanel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;
  
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
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        touchOutsideController(),
        widget.addictionalBut ?? const SizedBox.shrink(),
        panel(),
      ],
    );
  }

  Widget panel() {
    return AnimatedBuilder(
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
              if (_isExpanded) Animate(
                effects: const [FadeEffect(
                  delay: Duration(milliseconds: 200),
                  duration: Duration(milliseconds: 200),
                )],
                child: widget.content
              ),
            ]
          )
        );
      }
    );
  }

  Widget touchOutsideController() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = false;
          _controller.reverse().then((_) {
            widget.unload!();
            setState(() {});
          });
        });
      },
      child: Container(decoration: const BoxDecoration()),
    );
  }
}

class ExpandablePanelState extends SomeExpandablePanelState {//for class choose panel
  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.forcedActivating == 1 && !_isExpanded) {
      _controller.forward(); // Анимация при запуске извне
      setState(() {
        _isExpanded = true;
      });
    }
    else if (widget.forcedActivating == -1 && _isExpanded) {
      _controller.reverse(); // Анимация при запуске извне
      setState(() {
        _isExpanded = false;
      });
    }
  }
  
  @override
  Widget panel() {
    widget.onActive!(!_isExpanded);
    return GestureDetector( //для обработки нажатий по панели
      onTap: () {
        _controller.forward();
        setState(() {
          _isExpanded = true;
        });
      },
      child: super.panel(),
    );
  }
}

class AutoExpandablePanelState extends SomeExpandablePanelState { // for card choose panel
  @override
  void initState() {
    super.initState();
    _isExpanded = true;
    _controller.forward(); // Запускаем анимацию увеличения при создании
  }
}