import 'package:dashboard/src/classes/constents.class.dart';
import 'package:flutter/material.dart';

import '../../classes/enums.class.dart';

class Alert extends StatelessWidget {
  const Alert(
    this.message, {
    this.type = AlertType.primary,
    super.key,
  });

  final String message;
  final AlertType type;

  Color getColor() {
    switch (type) {
      case AlertType.success:
        return Colors.green;
      case AlertType.danger:
        return Colors.red;
      case AlertType.warning:
        return Colors.amber;
      case AlertType.info:
        return Colors.blue;
      default:
        return primaryColor;
    }
  }

  IconData getIcon() {
    switch (type) {
      case AlertType.success:
        return Icons.check_circle_rounded;
      case AlertType.danger:
        return Icons.cancel_rounded;
      case AlertType.warning:
        return Icons.warning_rounded;
      case AlertType.info:
        return Icons.info_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      width: double.infinity,
      child: Row(
        children: [
          Icon(getIcon(), color: color),
          const SizedBox(width: 10),
          Expanded(
            child: SelectableText(
              message,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
