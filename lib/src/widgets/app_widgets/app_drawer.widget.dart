import 'package:dashboard/src/providers/routes.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/constents.class.dart';
import '../../classes/routes.class.dart';
import 'app_logo.widget.dart';
import '../responsive.widget.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final provider = Get.find<RoutesProvider>();
  bool isLoading = true;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget getItem(Map<String, dynamic> item, {String? parent}) {
    final route = parent is String ? (parent + item['route']) : item['route'];
    if (item['type'] == 'link') {
      return ListTile(
        key: ValueKey(route),
        title: Text(item['name']),
        selected: provider.current == route,
        selectedTileColor: primaryColor.withOpacity(.2),
        onTap: () {
          Routes.toNamed(
            route,
            duplicate: true,
          );
        },
      );
    }
    if (item['type'] == 'menu') {
      final children = item['children'] as List<Map<String, dynamic>>;
      return ExpansionTile(
        key: ValueKey(route),
        title: Text(item['name']),
        childrenPadding: const EdgeInsets.only(left: 15),
        initiallyExpanded: provider.current.startsWith(route),
        backgroundColor: primaryColor.withOpacity(.05),
        shape: const BeveledRectangleBorder(),
        children: children.map((v) => getItem(v, parent: route)).toList(),
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
                child: GetBuilder<RoutesProvider>(
                  builder: (provider) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Scrollbar(
                        controller: scrollController,
                        child: ListView(
                          controller: scrollController,
                          children: drawerMenu.map(getItem).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Logo(full: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
