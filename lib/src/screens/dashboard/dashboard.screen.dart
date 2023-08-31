import 'package:dashboard/src/classes/constents.class.dart';
import 'package:dashboard/src/classes/enums.class.dart';
import 'package:dashboard/src/classes/functions.class.dart';
import 'package:dashboard/src/widgets/responsive_widgets/repesponsive_grid_item.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/dashboard_models/dashboard_card.model.dart';
import '../../widgets/menu_list.widget.dart';
import '../../widgets/responsive_widgets/responsive_grid.widget.dart';
import 'dashboard_widgets/dashboard_card.widget.dart';

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
                child: DashboardCard(
                  item,
                  callback: () {
                    Get.defaultDialog(
                      title: item.name,
                      radius: 30,
                      backgroundColor: Colors.white,
                      buttonColor: primaryColor,
                      content: const SizedBox(
                        width: 600,
                        height: 600,
                      ),
                      textConfirm: 'Confirm',
                      textCancel: 'Cancel',
                      onCancel: () {
                        Get.back();
                        toast('${item.name} adding canceled',
                            type: ToastType.danger);
                      },
                      onConfirm: () {
                        Get.back();
                        alert('${item.name} added success',
                            type: AlertType.success);
                      },
                    );
                  },
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
      ],
    );
  }
}
