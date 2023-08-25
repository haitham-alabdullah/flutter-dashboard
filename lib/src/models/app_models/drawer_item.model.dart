// ignore_for_file: hash_and_equals

import '../../classes/enums.class.dart';

class DrawerItem {
  bool isOpen;
  final DrawerItemType type;
  final String name;
  final String icon;
  final String route;
  final List<DrawerItem> children;

  DrawerItem({
    this.isOpen = false,
    this.type = DrawerItemType.link,
    required this.name,
    required this.icon,
    required this.route,
    this.children = const [],
  });

  factory DrawerItem.fromJson(Map<String, dynamic> json, {String? parent}) {
    if (parent is String) json['route'] = parent + json['route'];
    final List<Map<String, dynamic>> childrenMap = json['children'] ?? [];
    final List<DrawerItem> children = [];
    for (var child in childrenMap) {
      children.add(DrawerItem.fromJson(child, parent: json['route']));
    }
    return DrawerItem(
      type: children.isEmpty ? DrawerItemType.link : DrawerItemType.menu,
      name: json['name'],
      icon: json['icon'] ?? '',
      route: json['route'],
      children: children,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DrawerItem && other.name == name && other.route == route;
  }
}
