import 'package:get/get.dart';

import '../middlewares/auth.middleware.dart';
import '../screens/auth/login/login.screen.dart';
import '../screens/dashboard/dashboard.screen.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    title: 'Dashboard',
    name: DashboardScreen.route,
    page: () => const DashboardScreen(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    title: 'Login',
    name: LoginScreen.route,
    page: () => const LoginScreen(),
    middlewares: [GuestMiddleware()],
  )
];
