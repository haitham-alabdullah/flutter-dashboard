import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/auth.provider.dart';

class AuthMiddleware extends GetMiddleware {
  final authProvider = Get.find<AuthProvider>();

  @override
  RouteSettings? redirect(String? route) {
    return authProvider.isAuth || route == '/login'
        ? null
        : const RouteSettings(name: '/login');
  }

  @override
  GetPage<dynamic>? onPageCalled(GetPage<dynamic>? page) {
    print('>>> Page ${page?.name} called');
    print('>>> User ${authProvider.username} logged');
    return authProvider.username != null
        ? page?.copy(parameters: {'user': authProvider.username ?? ''})
        : page;
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    // This function will be called right before the Bindings are initialize,
    // then bindings is null
    bindings = [];
    return bindings;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    print('Bindings of ${page.toString()} are ready');
    return page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    print('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    print('PageDisposed');
  }
}

class GuestMiddleware extends GetMiddleware {
  final authProvider = Get.find<AuthProvider>();

  @override
  RouteSettings? redirect(String? route) {
    return authProvider.isAuth && route != '/'
        ? const RouteSettings(name: '/')
        : null;
  }
}
