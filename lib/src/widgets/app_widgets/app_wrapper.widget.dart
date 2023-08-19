import 'package:dashboard/src/providers/routes.provider.dart';
import 'package:dashboard/src/widgets/responsive.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_drawer.widget.dart';
import 'app_navbar.widget.dart';
import '../notifications_widgets/toast.widget.dart';

class WrapperWidget extends StatelessWidget {
  const WrapperWidget(this.widget, {super.key});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, screen) => Scaffold(
        key: Get.find<RoutesProvider>().mainKey,
        appBar: const AppNarBar(),
        extendBodyBehindAppBar: true,
        drawer: !screen.isDesktop ? const AppDrawer() : null,
        body: Stack(
          children: [
            Positioned.fill(
              child: Row(
                children: [
                  if (screen.isDesktop) const AppDrawer(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: widget,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 80,
              bottom: 20,
              right: 10,
              width: 400,
              child: Toasts(),
            ),
          ],
        ),
      ),
    );
  }
}
