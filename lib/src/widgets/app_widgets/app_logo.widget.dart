import 'package:flutter/material.dart';

import '../../classes/functions.class.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        svg('logo', size: 35),
        const SizedBox(width: 20),
        SelectableText(
          'Mocha Fusion',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
