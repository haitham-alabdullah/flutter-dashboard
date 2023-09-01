import 'package:flutter/material.dart';

import '../classes/constents.class.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    required this.child,
    this.callback,
    this.width = 300,
    this.height,
    super.key,
  });

  final Widget child;
  final VoidCallback? callback;
  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: cardShadow,
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}
