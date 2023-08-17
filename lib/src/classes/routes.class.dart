import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../middlewares/auth.middleware.dart';
import '../providers/routes.provider.dart';
import '../screens/auth/login/login.screen.dart';
import '../screens/main/main.screen.dart';
import '../widgets/simple_loader.widget.dart';

List<GetPage<dynamic>> appRoutes = [
  GetPage(
    title: 'Dashboard',
    name: MainScreen.route,
    page: () => const MainScreen(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    title: 'Login',
    name: LoginScreen.route,
    page: () => const LoginScreen(),
    middlewares: [GuestMiddleware()],
  )
];

Map<String, Widget Function()> internalRoutes = {
  '/': () => Center(
        child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 2), () {}),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: SimpleLoader());
              }
              return SizedBox(
                child: Text(
                  Get.find<RoutesProvider>().arguments.toString(),
                ),
              );
            }),
      ),
  '/menu/1': () => const SizedBox(child: Text('1')),
  '/menu/2': () => const SizedBox(child: Text('2')),
  '/menu/3': () => const SizedBox(child: Text('3')),
};

final List<Map<String, dynamic>> drawerMenu = [
  {
    'type': 'link',
    'name': 'Dashboard',
    'route': '/',
  },
  {
    'type': 'menu',
    'name': 'Menu',
    'route': '/menu',
    'children': [
      {
        'type': 'link',
        'name': 'Menu Item 1',
        'route': '/1',
      },
      {
        'type': 'link',
        'name': 'Menu Item 2',
        'route': '/2',
      },
      {
        'type': 'link',
        'name': 'Menu Item 3',
        'route': '/3',
      },
      {
        'type': 'link',
        'name': 'Menu Item 4',
        'route': '/4',
      },
    ],
  },
  {
    'type': 'menu',
    'name': 'Menu2',
    'route': '/menu2',
    'children': [
      {
        'type': 'link',
        'name': 'Menu2 Item 1',
        'route': '/1',
      },
      {
        'type': 'link',
        'name': 'Menu2 Item 2',
        'route': '/2',
      },
      {
        'type': 'link',
        'name': 'Menu2 Item 3',
        'route': '/3',
      },
      {
        'type': 'link',
        'name': 'Menu2 Item 4',
        'route': '/4',
      },
      {
        'type': 'menu',
        'name': 'Menu2 menu',
        'route': '/menu3',
        'children': [
          {
            'type': 'link',
            'name': 'Menu3 Item 1',
            'route': '/1',
          },
          {
            'type': 'link',
            'name': 'Menu3 Item 2',
            'route': '/2',
          },
          {
            'type': 'link',
            'name': 'Menu3 Item 3',
            'route': '/3',
          },
          {
            'type': 'link',
            'name': 'Menu3 Item 4',
            'route': '/4',
          },
        ],
      },
    ],
  },
];
