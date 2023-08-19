import 'package:dashboard/src/widgets/responsive.widget.dart';
import 'package:flutter/material.dart';

import '../../classes/constents.class.dart';
import '../../classes/functions.class.dart';
import '../account.widget.dart';
import '../navbar_buttom.widget.dart';
import 'app_search.widget.dart';
import 'app_logo.widget.dart';

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
        elevation: 5,
        leadingWidth: 70,
        toolbarHeight: preferredSize.height,
        backgroundColor: navbarColor,
        centerTitle: true,
        leading: !screen.isDesktop
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: IconButton.filledTonal(
                  icon: const Icon(Icons.menu),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor,
                    shadowColor: Colors.black26,
                    elevation: 5,
                    shape: const CircleBorder(),
                    // shape: const ContinuousRectangleBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    // ),
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
            if (screen.isDesktop)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Logo(),
              ),
            const Expanded(child: AppSearch()),
            if (!screen.isMobile)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!screen.isMobile)
                      SizedBox(
                        height: 50,
                        child: NavBarButtonWidget(
                          desktop: screen.isDesktop,
                          text: 'Show Model',
                          icon: Icons.add_rounded,
                          onTap: () => showModel('test'),
                        ),
                      ),
                    SizedBox(
                      height: 50,
                      child: AccountWidget(
                        desktop: screen.isDesktop,
                      ),
                    ),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
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
