import 'package:dashboard/src/classes/functions.class.dart';
import 'package:dashboard/src/widgets/responsive.widget.dart';
import 'package:flutter/material.dart';

import '../classes/constents.class.dart';
import 'app_search.widget.dart';
import 'logo.widget.dart';
import 'navbar_buttom.widget.dart';

class AppNarBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNarBar({
    this.title = 'SEA HORSE',
    super.key,
  });

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, screen) {
      return AppBar(
        leadingWidth: 70,
        leading: !screen.isDesktop
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton.filledTonal(
                  icon: const Icon(Icons.menu),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor,
                    shadowColor: Colors.black26,
                    elevation: 5,
                    shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              )
            : null,
        title: Row(
          children: [
            if (!screen.isMobile)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screen.isMobile
                      ? 0
                      : screen.isTablet
                          ? 10
                          : 25,
                ),
                child: Logo(full: screen.isDesktop),
              ),
            const AppSearch(),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!screen.isMobile)
                      SizedBox(
                        height: 55,
                        child: NavBarButtonWidget(
                          desktop: screen.isDesktop,
                          text: 'Show Model',
                          icon: Icons.add_rounded,
                          onTap: () => showModel('test'),
                        ),
                      ),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        toolbarHeight: preferredSize.height,
        backgroundColor: navbarColor,
      );
    });
  }
}
