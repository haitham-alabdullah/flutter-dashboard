import 'package:flutter/material.dart';

import '../../classes/functions.class.dart';

class Logo extends StatelessWidget {
  const Logo({this.logo = true, this.text = true, this.color, super.key});

  final bool logo;
  final bool text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (logo) svg('logo', size: 35, color: color),
        if (logo && text) const SizedBox(width: 20),
        if (text)
          SelectableText(
            'Mocha Fusion',
            style: Theme.of(context).textTheme.titleLarge,
          ),
      ],
    );
  }
}
