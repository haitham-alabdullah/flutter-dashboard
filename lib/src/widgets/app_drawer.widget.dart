import 'package:dashboard/src/providers/routes.provider.dart';
import 'package:dashboard/src/widgets/simple_loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/constents.class.dart';
import 'logo.widget.dart';
import 'responsive.widget.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final provider = Get.find<RoutesProvider>();
  bool isLoading = true;
  final List<Map<String, dynamic>> menu = [];
  final scrollController = ScrollController();

  @override
  void initState() {
    getSideMenu();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  loading(bool value) {
    if (mounted) {
      setState(() {
        isLoading = value;
      });
    }
  }

  Future<void> getSideMenu() async {
    loading(true);
    menu.clear();
    await Future.delayed(const Duration(seconds: 1), () {
      menu.add({
        'type': 'link',
        'name': 'Dashboard',
        'route': '/',
      });
      menu.add({
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
          }
        ],
      });
    });
    loading(false);
  }

  Widget getItem(Map<String, dynamic> item, {String? parent}) {
    if (item['type'] == 'link') {
      return ListTile(
        key: ValueKey(item['route']),
        title: Text(item['name']),
        selected: provider.current == item['route'],
        onTap: () {
          provider.changeRoute(
            parent is String ? (parent + item['route']) : item['route'],
          );
        },
      );
    }
    if (item['type'] == 'menu') {
      final children = item['children'] as List<Map<String, dynamic>>;
      return ExpansionTile(
        key: ValueKey(item['route']),
        title: Text(item['name']),
        initiallyExpanded: provider.current.startsWith(item['route']),
        backgroundColor: primaryColor.withOpacity(.05),
        shape: const BeveledRectangleBorder(),
        children:
            children.map((v) => getItem(v, parent: item['route'])).toList(),
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (cnx, screen) => Drawer(
        backgroundColor: drawerColor,
        shape: const ContinuousRectangleBorder(),
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: [
              if (screen.isMobile)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Logo(full: true),
                ),
              Expanded(
                child: isLoading
                    ? const Center(child: SimpleLoader())
                    : GetBuilder<RoutesProvider>(builder: (provider) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Scrollbar(
                            controller: scrollController,
                            child: ListView(
                              controller: scrollController,
                              children: menu.map(getItem).toList(),
                            ),
                          ),
                        );
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
