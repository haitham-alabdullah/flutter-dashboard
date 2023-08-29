import 'package:flutter/material.dart';

import '../../classes/functions.class.dart';

class Logo extends StatelessWidget {
  const Logo({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return svg('logo', size: 35, color: color);
  }
}
