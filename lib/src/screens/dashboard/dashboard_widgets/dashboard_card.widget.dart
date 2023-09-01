import 'package:flutter/material.dart';

import '../../../models/dashboard_models/dashboard_card.model.dart';
import '../../../widgets/animated_text.widget.dart';
import '../../../widgets/card.widget.dart';
import '../../../widgets/menu_list.widget.dart';
import '../../../widgets/rounded_progress_indicator.widget.dart';

class DashboardStatisticCard extends StatelessWidget {
  const DashboardStatisticCard(
    this.item, {
    super.key,
    this.isSmall = false,
    this.actions = const [],
    this.callback,
  });

  final DashboardCardModel item;
  final bool isSmall;
  final List<Widget> actions;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: item,
      child: CardWidget(
        callback: callback,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  item.icon,
                  size: 60,
                  color: Colors.black87,
                ),
                const Spacer(),
                RoundedProgressIndicator(
                  textValue: Text(
                    '+${item.persentageValue}%',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  value: (item.persentage) / 100,
                  backgroundColor: Colors.grey.shade200,
                  size: 50,
                  stroke: 6,
                ),
              ],
            ),
            const SizedBox(height: 5),
            SelectableText(
              item.name,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedNumber(
                        number: item.value,
                        style: Theme.of(
                          context,
                        ).textTheme.displayMedium?.copyWith(
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(height: 5),
                      SelectableText(
                        item.notes,
                        maxLines: 1,
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge?.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ],
                  ),
                ),
                actions.isNotEmpty
                    ? MenuList(
                        actions: actions,
                        offset: const Offset(0, 5),
                        builder: (controller) => IconButton.filledTonal(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(Icons.more_vert_rounded),
                        ),
                      )
                    : IconButton.filledTonal(
                        onPressed: callback,
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
