import 'package:dashboard/src/widgets/card.widget.dart';
import 'package:flutter/material.dart';

import '../../../demo.data.dart';
import '../../widgets/data_tables_widgets/data_table_card.widget.dart';
import '../../widgets/menu_list.widget.dart';
import '../../widgets/responsive_widgets/responsive_grid.widget.dart';
import '../../widgets/responsive_widgets/repesponsive_grid_item.widget.dart';
import 'dashboard_widgets/dashboard_card.widget.dart';
import 'dashboard_widgets/line_chart.widget.dart';
import 'dashboard_widgets/radial_chart.widget.dart';

class DashboadScreen extends StatefulWidget {
  const DashboadScreen({super.key});

  @override
  State<DashboadScreen> createState() => _DashboadScreenState();
}

class _DashboadScreenState extends State<DashboadScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveGrid(
      childrenBuilder: (cnx, screen) {
        return [
          ...dashboardCardModelValues
              .map(
                (item) => ResponsiveGridItem(
                  animationIndex: dashboardCardModelValues.indexOf(item),
                  crossAxisCellCount: screen.setAxis(6, 9, 6, 6),
                  child: DashboardStatisticCard(
                    item,
                    callback: () {},
                    isSmall: screen.isSmall,
                    actions: [
                      if (dashboardCardModelValues.indexOf(item) == 0)
                        MenuListItem(
                          callback: () {},
                          svgName: 'menu',
                          title: 'Details',
                        ),
                    ],
                  ),
                ),
              )
              .toList(),
          ResponsiveGridItem(
            animationIndex: 4,
            crossAxisCellCount: screen.setAxis(6, 9, 6, 6),
            child: CardWidget(
              height: 420,
              child: Column(
                children: [
                  Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SelectableText(
                          'Shot per distance',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const AnimationRadialChart(),
                ],
              ),
            ),
          ),
          ResponsiveGridItem(
            animationIndex: 5,
            crossAxisCellCount: screen.setAxis(6, 9, 6, 6),
            child: CardWidget(
              height: 420,
              child: Column(
                children: [
                  Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SelectableText(
                          'Revenue',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Spacer(),
                      const SelectableText('Last 7 days')
                    ],
                  ),
                  const Spacer(),
                  const AnimationSplineChart(),
                ],
              ),
            ),
          ),
          ResponsiveGridItem(
            animationIndex: 12,
            crossAxisCellCount: screen.setAxis(12, 18, 24, 24),
            child: CardWidget(
              height: 420,
              child: Column(
                children: [
                  Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SelectableText(
                          'Revenue',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Spacer(),
                      const SelectableText('Last 7 days VS period week')
                    ],
                  ),
                  const Spacer(),
                  const AnimationSplineChart(),
                ],
              ),
            ),
          ),
          ResponsiveGridItem(
            animationIndex: 7,
            crossAxisCellCount: 24,
            child: DataTableCard(screen.isBig, screen.is4K, screen.isMobile),
          ),
          const SizedBox(height: 30),
        ];
      },
    );
  }
}
