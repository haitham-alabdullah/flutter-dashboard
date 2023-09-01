import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../child_builder.widget.dart';

class ResponsiveGridItem extends StatelessWidget {
  const ResponsiveGridItem({
    required this.child,
    this.crossAxisCellCount = 3,
    this.animationIndex = 0,
    super.key,
  });

  final Widget child;
  final int crossAxisCellCount;
  final int animationIndex;

  @override
  Widget build(BuildContext context) {
    return ChildBuilder(
      child: AnimationConfiguration.staggeredGrid(
        position: animationIndex,
        duration: const Duration(milliseconds: 375),
        columnCount: 6,
        child: ScaleAnimation(
          child: FadeInAnimation(
            child: child,
          ),
        ),
      ),
      builder: (context, child) {
        return StaggeredGridTile.fit(
          crossAxisCellCount: crossAxisCellCount,
          child: child,
        );
      },
    );
  }
}
