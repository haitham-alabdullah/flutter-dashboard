import 'package:flutter/material.dart';

class AnimatedNumber extends StatefulWidget {
  const AnimatedNumber({
    Key? key,
    required this.number,
    this.separator = 3,
  }) : super(key: key);

  final int number;
  final int separator;

  @override
  State<AnimatedNumber> createState() => _AnimatedNumberState();
}

class _AnimatedNumberState extends State<AnimatedNumber>
    with SingleTickerProviderStateMixin {
  late Animation<int> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = IntTween(begin: 0, end: widget.number).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTextValue(
      animation: _animation,
      separator: widget.separator,
    );
  }
}

class AnimatedTextValue extends AnimatedWidget {
  final Animation<int> animation;
  const AnimatedTextValue({
    Key? key,
    required this.animation,
    required this.separator,
  }) : super(key: key, listenable: animation);

  final int separator;

  _separatValue(int value) {
    if (separator > 0 && value.toString().length > separator) {
      final String valueString = value.toString();
      final int valueLength = valueString.length;
      final int separatorIndex = valueLength - separator;
      final String valueBeforeSeparator =
          valueString.substring(0, separatorIndex);
      final String valueAfterSeparator = valueString.substring(separatorIndex);
      return '$valueBeforeSeparator,$valueAfterSeparator';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      _separatValue(animation.value),
      style: const TextStyle(
        fontSize: 26,
        height: 1.4,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
