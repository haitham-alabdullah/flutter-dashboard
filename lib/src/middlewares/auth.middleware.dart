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
