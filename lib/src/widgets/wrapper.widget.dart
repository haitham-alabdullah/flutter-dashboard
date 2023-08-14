import 'package:dashboard/src/widgets/responsive.widget.dart';
import 'package:flutter/material.dart';

import 'app_drawer.widget.dart';
import 'app_navbar.widget.dart';

class WrapperWidget extends StatefulWidget {
  const WrapperWidget(this.builder, {super.key});
  final Widget Function(ScreenSize) builder;
  @override
  State<WrapperWidget> createState() => WrapperWidgetState();
}

class WrapperWidgetState extends State<WrapperWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, screen) => Scaffold(
        appBar: const AppNarBar(),
        extendBodyBehindAppBar: true,
        drawer: !screen.isDesktop ? const AppDrawer() : null,
        body: Row(
          children: [
            if (screen.isDesktop) const AppDrawer(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: widget.builder(screen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
