import 'package:dashboard/src/providers/alert.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/constents.class.dart';
import '../../providers/routes.provider.dart';
import '../../widgets/app_widgets/app_breadcamp.widget.dart';
import '../../widgets/app_widgets/app_drawer.widget.dart';
import '../../widgets/app_widgets/app_navbar.widget.dart';
import '../../widgets/notifications_widgets/toast.widget.dart';
import '../../widgets/responsive_widgets/responsive.widget.dart';

class MainScreen extends StatefulWidget {
  static const route = '/';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, screen) => GetBuilder<RoutesProvider>(
        init: RoutesProvider(),
        builder: (router) {
          return Scaffold(
            key: router.mainKey,
            appBar: const AppNarBar(),
            drawer: !screen.isDesktop ? const AppDrawer() : null,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (screen.isDesktop) const AppDrawer(),
                      Expanded(
                        child: Column(
                          children: [
                            GetBuilder<AlertProvider>(
                              builder: (alerter) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: alerter.alert ?? const SizedBox(),
                                );
                              },
                            ),
                            if (showBreadCamp) const BreadCrumbWidget(),
                            Expanded(
                              child: router.currentWidget.call(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  top: 0,
                  right: 10,
                  width: 400,
                  child: Toasts(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
