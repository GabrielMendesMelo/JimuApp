import 'package:flutter/material.dart';

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;
  final List<TweenSequenceItem<Color?>> tweenSequenceItens;

  const AnimatedProgressIndicator({
    required this.value,
    required this.tweenSequenceItens,
    super.key,
  });

  @override
  State<AnimatedProgressIndicator> createState() =>
      _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);

    final TweenSequence<Color?> colorTween =
        TweenSequence<Color?>(widget.tweenSequenceItens);
    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(
      CurveTween(curve: Curves.easeIn),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (
        BuildContext context,
        Widget? child,
      ) =>
          LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withOpacity(0.4),
      ),
    );
  }
}
