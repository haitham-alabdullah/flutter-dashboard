import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../classes/constents.class.dart';
import 'responsive.widget.dart';

class ResponsiveGrid extends StatefulWidget {
  const ResponsiveGrid({required this.childrenBuilder, super.key});

  final List<Widget> Function(
    BuildContext,
    ScreenSize,
  ) childrenBuilder;

  @override
  State<ResponsiveGrid> createState() => _ResponsiveGridState();
}

class _ResponsiveGridState extends State<ResponsiveGrid> {
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (cnx, screen) {
        return Scrollbar(
          thickness: 15,
          thumbVisibility: true,
          controller: controller,
          child: SingleChildScrollView(
            controller: controller,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: (Get.width - 304) > maxContainerWidth
                    ? (((Get.width - 304) - maxContainerWidth) / 2)
                    : 0,
              ),
              child: AnimationLimiter(
                child: StaggeredGrid.count(
                  crossAxisCount: screen.gridAxis(),
                  children: widget.childrenBuilder(cnx, screen),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
