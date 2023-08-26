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

  List<Widget> getMenu(DrawerItem item) {
    if (item.type == DrawerItemType.menu) {
      final children = item.children;
      return children.map(getItem).toList();
    }
    return [];
  }

  Widget getItem(DrawerItem item, {String? parent, bool sub = true}) {
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
          title: Text(
            item.name,
            selectionColor: Colors.grey.shade900,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: item.isOpen ? FontWeight.w600 : FontWeight.w500,
                  fontSize: sub ? 14 : null,
                ),
          ),
          // childrenPadding: const EdgeInsets.only(left: 10),
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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: ListTile(
        key: ValueKey(item),
        title: Text(item.name),
        dense: sub,
        leading: svg(
          item.icon,
          size: sub ? 15 : 20,
          color: selected ? Colors.blueGrey.shade800 : Colors.blueGrey,
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
          // closeDrawerMenu(item.route);
          if (provider.isDrawerOpen) {
            provider.closeDrawer();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, screen) {
      return GetBuilder<RoutesProvider>(builder: (provider) {
        return Row(
          children: [
            NavigationRail(
              onDestinationSelected: (value) {
                final item = drawerMenu[value];
                if (item.type == DrawerItemType.link) {
                  Routes.toNamed(
                    item.route,
                    duplicate: true,
                  );
                  if (provider.isDrawerOpen) {
                    provider.closeDrawer();
                  }
                }
                provider.currentIndex = value;
                provider.update();
                // change(value);
              },
              useIndicator: true,
              indicatorColor: Colors.white,
              backgroundColor: primaryColor,
              labelType: NavigationRailLabelType.all,
              unselectedLabelTextStyle: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.white70),
              selectedLabelTextStyle: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.white),
              indicatorShape: ContinuousRectangleBorder(
                side: BorderSide(color: Colors.grey.withOpacity(.2), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              leading: Visibility(
                visible: !screen.isDesktop,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Logo(
                    text: false,
                    color: Colors.white,
                  ),
                ),
              ),
              destinations: [
                ...drawerMenu
                    .map<NavigationRailDestination>(
                      (item) => NavigationRailDestination(
                        padding: const EdgeInsets.all(10),
                        icon: svg(
                          item.icon,
                          size: 20,
                          color: Colors.white70,
                        ),
                        selectedIcon: svg(
                          item.icon,
                          size: 20,
                        ),
                        label: Text(item.name),
                      ),
                    )
                    .toList(),
              ],
              selectedIndex: provider.currentIndex,
            ),
            if (provider.currentMenu.children.isNotEmpty)
              Drawer(
                backgroundColor: drawerColor,
                shape: const ContinuousRectangleBorder(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      if (!screen.isDesktop)
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 33, left: 20, right: 20),
                          child: Logo(logo: false),
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
                                  children: getMenu(provider.currentMenu),
                                  // children: drawerMenu.map(getItem).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        );
      });
    });

    // return ResponsiveWidget(
    //   builder: (cnx, screen) => Drawer(
    //     backgroundColor: drawerColor,
    //     shape: const ContinuousRectangleBorder(),
    //     child: Padding(
    //       padding: const EdgeInsets.only(top: 0),
    //       child: Column(
    //         children: [
    //           if (!screen.isDesktop)
    //             const Padding(
    //               padding: EdgeInsets.all(20),
    //               child: Logo(),
    //             ),
    //           Expanded(
    //             child: GetBuilder<RoutesProvider>(
    //               builder: (provider) {
    //                 return Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 10),
    //                   child: Scrollbar(
    //                     controller: scrollController,
    //                     child: ListView(
    //                       controller: scrollController,
    //                       children: drawerMenu.map(getItem).toList(),
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
