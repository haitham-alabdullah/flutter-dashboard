import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          child: SingleChildScrollView(
            primary: true,
            child: StaggeredGrid.count(
              crossAxisCount: screen.gridAxis(),
              children: widget.children,
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
