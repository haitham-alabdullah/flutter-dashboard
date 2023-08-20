import 'package:dashboard/src/classes/enums.class.dart';
import 'package:dashboard/src/widgets/notifications_widgets/alert.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../widgets/responsive_grid.widget.dart';

class DashboadScreen extends StatefulWidget {
  const DashboadScreen({super.key});

  @override
  State<DashboadScreen> createState() => _DashboadScreenState();
}

class _DashboadScreenState extends State<DashboadScreen> {
  String alertMessage = '';

  setAlert(String message) {
    if (mounted) {
      setState(() {
        alertMessage = message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (alertMessage.isNotEmpty)
          Alert(
            alertMessage,
            type: AlertType.info,
            key: ValueKey(alertMessage.hashCode),
            dismissible: true,
            onDismiss: () => setAlert(''),
          ),
        Expanded(
          child: ResponsiveGrid(
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
          ),
        ),
      ],
    );
  }
}
