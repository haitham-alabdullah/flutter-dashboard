import 'package:flutter/material.dart';

import '../../classes/functions.class.dart';

class Logo extends StatelessWidget {
  const Logo({this.full = false, super.key});

  final bool full;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          imgUrl('logo.png'),
          width: 60,
          height: 60,
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.scaleDown,
        ),
        if (full) ...[
          const SizedBox(width: 20),
          SelectableText(
            'Mocha Fusion',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ],
    );
  }
}
