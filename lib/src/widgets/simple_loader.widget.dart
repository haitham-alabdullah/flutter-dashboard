import 'package:flutter/material.dart';

class SimpleLoader extends StatelessWidget {
  const SimpleLoader({
    this.color,
    this.strokeWidth = 4,
    this.size = 40,
    super.key,
  });

  final Color? color;
  final double strokeWidth;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(color),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
