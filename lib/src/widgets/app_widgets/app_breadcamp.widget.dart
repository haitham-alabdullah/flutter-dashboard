import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:get/get.dart';

import '../../classes/constents.class.dart';
import '../../providers/routes.provider.dart';

class BreadCrumbWidget extends StatelessWidget {
  const BreadCrumbWidget({this.onBreadTap, super.key});

  final void Function(String)? onBreadTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoutesProvider>(
      builder: (router) {
        final items = router.current.trim().replaceFirst('/', '').split('/');
        return Visibility(
          visible: items.isNotEmpty,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: BreadCrumb(
                    items: items
                        .map(
                          (e) => BreadCrumbItem(
                            padding: const EdgeInsets.all(5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            onTap: onBreadTap == null
                                ? null
                                : () {
                                    final route = items
                                        .getRange(0, items.indexOf(e) + 1)
                                        .toList()
                                        .join('/');
                                    onBreadTap?.call('/$route');
                                  },
                            content: Text(
                              e.capitalize.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: onBreadTap == null
                                        ? Colors.grey.shade600
                                        : primaryColor,
                                  ),
                            ),
                          ),
                        )
                        .toList(),
                    divider: Text(
                      ' / ',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    overflow: const WrapOverflow(
                      keepLastDivider: false,
                      direction: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
