import 'package:dashboard/src/classes/functions.class.dart';
import 'package:dashboard/src/providers/routes.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/constents.class.dart';
import '../../classes/enums.class.dart';
import '../../classes/routes.class.dart';
import '../../models/app_models/drawer_item.model.dart';
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget getItem(DrawerItem item, {String? parent, bool sub = false}) {
    if (item.type == DrawerItemType.menu) {
      final children = item.children;
      // if (provider.current.startsWith(item.route) && !item.isOpen) {
      //   item.isOpen = true;
      // }
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 1,
        ),
        child: ExpansionTile(
          key: GlobalKey(),
          leading: svg(
            item.icon,
            size: sub ? 15 : 20,
            color: item.isOpen ? Colors.blueGrey.shade800 : Colors.blueGrey,
          ),
          onExpansionChanged: (value) {
            closeDrawerMenu(item.route);
            Future.delayed(const Duration(milliseconds: 250), () {
              setState(() {
                item.isOpen = value;
              });
            });
          },
          title: Text(
            item.name,
            selectionColor: Colors.grey.shade900,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: item.isOpen ? FontWeight.w600 : FontWeight.w500,
                  fontSize: sub ? 14 : null,
                ),
          ),
          trailing: AnimatedCrossFade(
            crossFadeState: item.isOpen
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(microseconds: 400),
            firstChild: const Icon(Icons.add_rounded),
            secondChild: const Icon(Icons.remove_rounded),
          ),
          childrenPadding: const EdgeInsets.only(left: 10),
          initiallyExpanded: item.isOpen,
          backgroundColor: Colors.grey.withOpacity(.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          children: children.map((v) => getItem(v, sub: true)).toList(),
        ),
      );
    }
    final selected = provider.current == item.route;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 1,
      ),
      child: ListTile(
        key: ValueKey(item),
        title: Text(item.name),
        dense: sub,
        leading: svg(
          item.icon,
          size: sub ? 15 : 20,
          color: selected ? Colors.blueGrey.shade800 : Colors.blueGrey,
        ),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
        selectedColor: Colors.grey.shade900,
        hoverColor: Colors.grey.withOpacity(.1),
        selected: selected,
        selectedTileColor: Colors.grey.withOpacity(.2),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        style: ListTileStyle.drawer,
        onTap: () {
          Routes.toNamed(
            item.route,
            duplicate: true,
          );
          closeDrawerMenu(item.route);
          if (provider.isDrawerOpen) {
            provider.closeDrawer();
          }
        },
      ),
    );
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
              if (!screen.isDesktop)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Logo(),
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
            ],
          ),
        ),
      ),
    );
  }
}
