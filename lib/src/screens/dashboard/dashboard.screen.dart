import 'package:dashboard/src/classes/enums.class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../classes/functions.class.dart';
import '../../widgets/responsive_grid.widget.dart';

class DashboadScreen extends StatefulWidget {
  const DashboadScreen({super.key});

  @override
  State<DashboadScreen> createState() => _DashboadScreenState();
}

class _DashboadScreenState extends State<DashboadScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveGrid(
      children: [
        StaggeredGridTile.fit(
          crossAxisCellCount: 3,
          child: GestureDetector(
            onTap: () => alert('message', type: AlertType.success),
            child: Container(
              key: const ValueKey(1),
              height: 300,
              width: 300,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.amber,
              ),
              child: Center(child: SelectableText((1).toString())),
            ),
          ),
        ),
      ],
    );
  }
}
