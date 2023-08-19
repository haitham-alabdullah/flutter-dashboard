import 'package:dashboard/src/models/app_models/drawer_item.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../middlewares/auth.middleware.dart';
import '../screens/auth/login/login.screen.dart';
import '../screens/dashboard/dashboard.screen.dart';
import '../screens/main/main.screen.dart';

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
  '/': () => const DashboadScreen(),
  '/menu/1': () => const SizedBox(child: Text('1')),
  '/menu/2': () => const SizedBox(child: Text('2')),
  '/menu/3': () => const SizedBox(child: Text('3')),
  '/menu/4': () => const SizedBox(child: Text('4')),
};

final List<Map<String, dynamic>> drawerMenuMap = [
  {
    'type': 'link',
    'name': 'Dashboard',
    'icon': 'dashboard',
    'route': '/',
  },
  {
    'type': 'menu',
    'name': 'Menu',
    'icon': 'menu',
    'route': '/menu',
    'children': [
      {
        'type': 'link',
        'name': 'Menu Item 1',
        'icon': 'dot',
        'route': '/1',
      },
      {
        'type': 'link',
        'name': 'Menu Item 2',
        'icon': 'dot',
        'route': '/2',
      },
      {
        'type': 'link',
        'name': 'Menu Item 3',
        'icon': 'dot',
        'route': '/3',
      },
      {
        'type': 'link',
        'name': 'Menu Item 4',
        'icon': 'dot',
        'route': '/4',
      },
    ],
  },
  {
    'type': 'menu',
    'name': 'Menu2',
    'icon': 'menu',
    'route': '/menu2',
    'children': [
      {
        'type': 'link',
        'name': 'Menu2 Item 1',
        'icon': 'dot',
        'route': '/1',
      },
      {
        'type': 'link',
        'name': 'Menu2 Item 2',
        'icon': 'dot',
        'route': '/2',
      },
      {
        'type': 'link',
        'name': 'Menu2 Item 3',
        'icon': 'dot',
        'route': '/3',
      },
      {
        'type': 'link',
        'name': 'Menu2 Item 4',
        'icon': 'dot',
        'route': '/4',
      },
      {
        'type': 'menu',
        'name': 'Menu2 menu',
        'icon': 'menu',
        'route': '/menu3',
        'children': [
          {
            'type': 'link',
            'name': 'Menu3 Item 1',
            'icon': 'dot',
            'route': '/1',
          },
          {
            'type': 'link',
            'name': 'Menu3 Item 2',
            'icon': 'dot',
            'route': '/2',
          },
          {
            'type': 'link',
            'name': 'Menu3 Item 3',
            'icon': 'dot',
            'route': '/3',
          },
          {
            'type': 'link',
            'name': 'Menu3 Item 4',
            'icon': 'dot',
            'route': '/4',
          },
        ],
      },
    ],
  },
  {
    'type': 'link',
    'name': 'Account',
    'icon': 'account',
    'route': '/account',
  },
];

final List<DrawerItem> drawerMenu =
    drawerMenuMap.map(DrawerItem.fromJson).toList();
