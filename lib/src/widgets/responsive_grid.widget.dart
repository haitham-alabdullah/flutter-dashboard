import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../classes/constents.class.dart';
import 'responsive.widget.dart';

class ResponsiveGrid extends StatefulWidget {
  const ResponsiveGrid({required this.children, super.key});
  final List<StaggeredGridTile> children;

  @override
  State<ResponsiveGrid> createState() => _ResponsiveGridState();
}

class _ResponsiveGridState extends State<ResponsiveGrid>
    with AutomaticKeepAliveClientMixin<ResponsiveGrid> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ResponsiveWidget(
      builder: (cnx, screen) {
        return Scrollbar(
          thickness: 15,
          thumbVisibility: true,
          child: SingleChildScrollView(
            primary: true,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: (Get.width - 304) > maxContainerWidth
                    ? (((Get.width - 304) - maxContainerWidth) / 2)
                    : 0,
              ),
              child: StaggeredGrid.count(
                crossAxisCount: screen.gridAxis(),
                children: widget.children,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
