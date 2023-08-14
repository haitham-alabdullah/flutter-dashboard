import 'package:flutter/material.dart';

import '../classes/constents.class.dart';
import 'logo.widget.dart';
import 'responsive.widget.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Scrollbar(
                    controller: scrollController,
                    child: ListView(
                      controller: scrollController,
                      children: List.generate(
                        100,
                        (index) => index % 3 == 0
                            ? ExpansionTile(
                                title: Text('menu number $index'),
                                backgroundColor: primaryColor.withOpacity(.05),
                                shape: const BeveledRectangleBorder(),
                                children: List.generate(
                                  2,
                                  (index) => ListTile(
                                    title: Text('item number $index'),
                                    onTap: () => print(index),
                                  ),
                                ),
                              )
                            : ListTile(
                                title: Text('item number $index'),
                                onTap: () => print(index),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
