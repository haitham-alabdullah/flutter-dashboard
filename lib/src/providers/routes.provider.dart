import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/errors/404.screen.dart';

class RoutesProvider extends GetxController {
  final RxString _current = RxString('/');

  String get current => _current.value;

  Widget get currentWidget =>
      internalRoutes[current]?.call() ?? const Error404Screen();

  void changeRoute(String newRoute) {
    if (newRoute.startsWith('/') && newRoute != _current.value) {
      _current.value = newRoute;
      update();
    }
  }
}

Map<String, Widget Function()> internalRoutes = {
  '/': () => const Center(child: SizedBox(child: Text('dashboard'))),
  '/menu/1': () => const SizedBox(child: Text('1')),
  '/menu/2': () => const SizedBox(child: Text('2')),
  '/menu/3': () => const SizedBox(child: Text('3')),
};
