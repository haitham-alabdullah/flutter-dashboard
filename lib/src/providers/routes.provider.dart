import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/routes.class.dart';
import '../screens/errors/404.screen.dart';

class Routes {
  static void to(Widget Function() screen, {dynamic arguments}) {
    Get.find<RoutesProvider>().to(screen, arguments: arguments);
  }

  static void toNamed(
    String newRoute, {
    duplicate = false,
    dynamic arguments,
  }) {
    Get.find<RoutesProvider>().toNamed(
      newRoute,
      arguments: arguments,
      duplicate: duplicate,
    );
  }
}

class RoutesProvider extends GetxController {
  final RxString _current = RxString('/');
  final Rx<Widget Function()?> _currentWidget = Rx<Widget Function()?>(null);
  final Rx<dynamic> _arguments = Rx<dynamic>(null);

  String get current => _current.value;
  dynamic get arguments => _arguments.value;

  Widget Function() get currentWidget => _currentWidget.value != null
      ? _currentWidget.value!
      : (internalRoutes[current] ?? () => const Error404Screen());

  set currentWidget(v) => _currentWidget.value = v;

  void toNamed(String newRoute, {duplicate = false, dynamic arguments}) {
    if (newRoute.startsWith('/')) {
      if (duplicate) {
        _arguments.value = arguments;
        _current.value = newRoute;
        _currentWidget.value = null;
        update();
      } else if (newRoute != _current.value) {
        _arguments.value = arguments;
        _current.value = newRoute;
        _currentWidget.value = null;
        update();
      }
    }
  }

  to(Widget Function() screen, {dynamic arguments}) {
    _current.value = '-';
    _arguments.value = arguments;
    currentWidget = screen;
    update();
  }
}
