import 'package:dashboard/src/widgets/card.widget.dart';
import 'package:flutter/material.dart';

import '../../models/dashboard_models/dashboard_card.model.dart';
import '../../widgets/menu_list.widget.dart';
import '../../widgets/responsive_widgets/responsive_grid.widget.dart';
import '../../widgets/responsive_widgets/repesponsive_grid_item.widget.dart';
import 'dashboard_widgets/dashboard_card.widget.dart';
import 'dashboard_widgets/data_table.widget.dart';
import 'dashboard_widgets/line_chart.widget.dart';
import 'dashboard_widgets/radial_chart.widget.dart';

class DashboadScreen extends StatefulWidget {
  const DashboadScreen({super.key});

  @override
  State<DashboadScreen> createState() => _DashboadScreenState();
}

class _DashboadScreenState extends State<DashboadScreen> {
  final values = [
    DashboardCardModel.fromJson({
      'name': 'Projects',
      'icon': Icons.precision_manufacturing_rounded,
      'value': 327,
      'persentage': 32.1,
      'persentageValue': '2.1',
      'notes': '8k social visitors',
    }),
    DashboardCardModel.fromJson({
      'name': 'Stock Qty',
      'icon': Icons.add_chart_rounded,
      'value': 275,
      'persentage': 64.1,
      'persentageValue': '3.1',
      'notes': 'Total 424,567 deliveries',
    }),
    DashboardCardModel.fromJson({
      'name': 'C APEX',
      'icon': Icons.apple_rounded,
      'value': 648,
      'persentage': 72.1,
      'persentageValue': '12.1',
      'notes': 'Counted in Millions',
    }),
    DashboardCardModel.fromJson({
      'name': 'Saving',
      'icon': Icons.data_saver_off_rounded,
      'value': 18478,
      'persentage': 24.1,
      'persentageValue': '0.1',
      'notes': 'Reports by states and ganders',
    }),
  ];
  @override
  Widget build(BuildContext context) {
    return ResponsiveGrid(
      childrenBuilder: (cnx, screen) => [
        ...values
            .map(
              (item) => ResponsiveGridItem(
                animationIndex: values.indexOf(item),
                crossAxisCellCount: 3,
                child: DashboardStatisticCard(
                  item,
                  callback: () {},
                  isSmall: screen.isSmall,
                  actions: [
                    if (values.indexOf(item) == 0)
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
          crossAxisCellCount: 3,
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
          crossAxisCellCount: 3,
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
          animationIndex: 6,
          crossAxisCellCount: screen.isSmall ? 12 : 6,
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
          crossAxisCellCount: 12,
          child: CardWidget(
            height: 700,
            child: Column(
              children: [
                Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SelectableText(
                        'Users',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Expanded(
                  child: DataTableWidget(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
