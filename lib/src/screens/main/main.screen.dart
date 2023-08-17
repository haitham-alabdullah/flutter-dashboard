import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/routes.provider.dart';
import '../../widgets/app_widgets/app_wrapper.widget.dart';

class MainScreen extends StatefulWidget {
  static const route = '/';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return WrapperWidget(
      GetBuilder<RoutesProvider>(
        builder: (routes) {
          return routes.currentWidget.call();
        },
      ),
    );
  }
}
