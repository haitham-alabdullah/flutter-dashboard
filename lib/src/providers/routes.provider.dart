import 'package:dashboard/src/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/functions.class.dart';
import '../classes/routes.class.dart';
import '../models/app_models/drawer_item.model.dart';
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
    closeDrawerMenu(newRoute);
  }
}

class RoutesProvider extends GetxController {
  GlobalKey<ScaffoldState>? mainKey = GlobalKey();
  final RxInt _selectedIndex = RxInt(0);
  final RxString _current = RxString('/dashboard');
  final Rx<Widget Function()?> _currentWidget = Rx<Widget Function()?>(null);
  final Rx<dynamic> _arguments = Rx<dynamic>(null);

  int get currentIndex => _selectedIndex.value;
  String get current => _current.value;
  dynamic get arguments => _arguments.value;
  bool get isDrawerOpen => mainKey?.currentState?.isDrawerOpen ?? false;

  Widget Function() get currentWidget => getWidget();
  DrawerItem get currentMenu => drawerMenu[currentIndex];

  set currentWidget(Widget Function()? v) => _currentWidget.value = v;
  set currentIndex(int v) => _selectedIndex.value = v;

  Widget Function() getWidget() {
    final auth = Get.find<AuthProvider>();
    if (!auth.isAuth) {
      auth.logout();
      return () => const Error404Screen();
    }
    return _currentWidget.value != null
        ? _currentWidget.value!
        : (internalRoutes[current] ?? () => const Error404Screen());
  }

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

    print(newRoute);
    try {
      currentIndex = menuIndex(newRoute);
      update();
    } catch (e) {
      print(e);
    }
  }

  to(Widget Function() screen, {dynamic arguments}) {
    _current.value = '-';
    _arguments.value = arguments;
    currentWidget = screen;
    update();
  }

  void toggleDrawer() {
    if (mainKey?.currentState?.isDrawerOpen ?? false) {
      mainKey?.currentState?.openDrawer();
    } else {
      mainKey?.currentState?.closeDrawer();
    }
  }

  void closeDrawer() {
    try {
      mainKey?.currentState?.closeDrawer();
    } catch (e) {
      //
    }
  }
}
