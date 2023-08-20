import 'package:dashboard/src/classes/constents.class.dart';
import 'package:flutter/material.dart';

import '../../classes/enums.class.dart';

class Alert extends StatefulWidget {
  const Alert(
    this.message, {
    this.type = AlertType.primary,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  });

  final String message;
  final AlertType type;
  final bool dismissible;
  final VoidCallback? onDismiss;

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  bool isVisible = true;

  @override
  void initState() {
    isVisible = true;
    super.initState();
  }

  Color getColor() {
    switch (widget.type) {
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
    switch (widget.type) {
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

  dissmiss() {
    if (mounted) {
      setState(() {
        isVisible = false;
      });
      if (widget.onDismiss is VoidCallback) widget.onDismiss?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 150),
      crossFadeState:
          isVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      secondChild: const SizedBox.shrink(),
      firstChild: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: color.withOpacity(.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 5),
            Icon(getIcon(), color: color),
            const SizedBox(width: 10),
            Expanded(
              child: SelectableText(
                widget.message,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: color),
              ),
            ),
            if (widget.dismissible) ...[
              const SizedBox(width: 10),
              InkWell(
                onTap: dissmiss,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                radius: 25,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.1),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    'clear',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ],
        ),
      ),
    );
  }
}
