import 'package:dashboard/src/widgets/responsive_widgets/responsive.widget.dart';
import 'package:flutter/material.dart';

import '../../classes/constents.class.dart';
import '../../classes/functions.class.dart';
import '../account.widget.dart';
import '../navbar_buttom.widget.dart';
import 'app_logo.widget.dart';
import 'app_search.widget.dart';

class AppNarBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNarBar({
    this.title = '',
    super.key,
  });

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, screen) {
      return AppBar(
        elevation: 5,
        shadowColor: Colors.black26,
        scrolledUnderElevation: 5,
        leadingWidth: 92,
        toolbarHeight: preferredSize.height,
        backgroundColor: navbarColor,
        centerTitle: true,
        leading: !screen.isBig
            ? Container(
                width: 92,
                padding: const EdgeInsets.all(12),
                child: IconButton.filledTonal(
                  icon: const Icon(Icons.menu),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor,
                    shadowColor: Colors.black26,
                    elevation: 5,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              )
            : Container(
                color: primaryColor,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Logo(color: Colors.white),
                ),
              ),
        title: Row(
          children: [
            const Expanded(
              child: Center(
                child: SizedBox(
                  width: 900,
                  child: AppSearch(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!screen.isMobile)
                    SizedBox(
                      height: 50,
                      child: NavBarButtonWidget(
                        desktop: screen.isBig,
                        text: 'Show Model',
                        icon: Icons.add_rounded,
                        onTap: () => showModel('test'),
                      ),
                    ),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [],
                  ),
                  SizedBox(
                    height: 50,
                    child: AccountWidget(
                      desktop: screen.isBig,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
