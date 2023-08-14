import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/routes.provider.dart';
import '../../widgets/wrapper.widget.dart';

class DashboardScreen extends StatefulWidget {
  static const route = '/';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return WrapperWidget(
      (screen) => GetBuilder<RoutesProvider>(builder: (routes) {
        return routes.currentWidget;
      }),
    );
  }
}
