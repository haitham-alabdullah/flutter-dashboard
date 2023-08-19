import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../widgets/responsive_grid.widget.dart';
import '../../widgets/simple_loader.widget.dart';

class DashboadScreen extends StatefulWidget {
  const DashboadScreen({super.key});

  @override
  State<DashboadScreen> createState() => _DashboadScreenState();
}

class _DashboadScreenState extends State<DashboadScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 0), () {}),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: SimpleLoader());
          }
          return ResponsiveGrid(
            children: [
              ...List.generate(
                50,
                (index) => StaggeredGridTile.fit(
                  crossAxisCellCount: 3,
                  child: Container(
                    key: ValueKey(index),
                    height: 300,
                    width: 300,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.amber,
                    ),
                    child:
                        Center(child: SelectableText((index + 1).toString())),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
