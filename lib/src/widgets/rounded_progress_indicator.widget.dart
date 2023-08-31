import 'package:dashboard/src/classes/constents.class.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class RoundedProgressIndicator extends StatefulWidget {
  const RoundedProgressIndicator({
    this.textValue,
    this.color = primaryColor,
    this.backgroundColor = Colors.white,
    this.value = 0.5,
    this.size = 40,
    this.stroke = 4,
    super.key,
  });

  final Widget? textValue;
  final Color color;
  final Color backgroundColor;
  final double value;
  final double size;
  final double stroke;

  @override
  State<RoundedProgressIndicator> createState() =>
      _RoundedProgressIndicatorState();
}

class _RoundedProgressIndicatorState extends State<RoundedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0, end: widget.value).animate(CurvedAnimation(
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
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: widget.textValue is Widget
          ? Stack(
              children: [
                Positioned.fill(
                  child: AnimatedRoundedProgressIndicator(
                    backgroundColor: widget.backgroundColor,
                    color: widget.color,
                    stroke: widget.stroke,
                    animation: _animation,
                  ),
                ),
                Positioned.fill(
                  child: Center(child: widget.textValue as Widget),
                ),
              ],
            )
          : AnimatedRoundedProgressIndicator(
              backgroundColor: widget.backgroundColor,
              color: widget.color,
              stroke: widget.stroke,
              animation: _animation,
            ),
    );
  }
}

class AnimatedRoundedProgressIndicator extends AnimatedWidget {
  const AnimatedRoundedProgressIndicator({
    Key? key,
    this.color = primaryColor,
    this.backgroundColor = Colors.white,
    this.stroke = 4,
    required this.animation,
  }) : super(key: key, listenable: animation);

  final Animation<double> animation;
  final Color color;
  final Color backgroundColor;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CartCircularprogress(
        backColor: backgroundColor,
        frontColor: color,
        strokeWidth: stroke,
        value: animation.value,
      ),
    );
  }
}

class CartCircularprogress extends CustomPainter {
  const CartCircularprogress({
    required this.backColor,
    required this.frontColor,
    required this.strokeWidth,
    required this.value,
  });
  final Color backColor, frontColor;
  final double strokeWidth, value;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final paint1 = Paint()
      ..strokeWidth = strokeWidth
      ..color = backColor
      ..style = PaintingStyle.stroke;
    final paint2 = Paint()
      ..strokeWidth = strokeWidth
      ..color = frontColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final r =
        Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h);

    canvas.drawArc(r, math.radians(0), math.radians(360), false, paint1);
    canvas.drawArc(
        r, math.radians(270), math.radians(360 * value), false, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
