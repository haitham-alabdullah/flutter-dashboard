import 'package:dashboard/src/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/routes.provider.dart';
import 'menu_list.widget.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    required this.desktop,
    super.key,
  });

  final bool desktop;

  @override
  Widget build(BuildContext context) {
    return MenuList(
      actions: [
        MenuListItem(
          callback: () => Routes.toNamed('/settings/account'),
          svgName: 'profile',
          title: 'Profile',
        ),
        MenuListItem(
          callback: Get.find<AuthProvider>().logout,
          svgName: 'logout',
          title: 'Logout',
          color: Colors.redAccent,
        ),
      ],
      builder: (controller) => GestureDetector(
        onTap: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: Container(
          width: desktop ? 200 : null,
          padding: const EdgeInsets.symmetric(horizontal: 7),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: desktop ? Colors.grey.shade100 : null,
          ),
          child: GetBuilder<AuthProvider>(builder: (provider) {
            return desktop
                ? Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          provider.profile?.image ?? '',
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              provider.profile?.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              provider.profile?.email ?? '',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      provider.profile?.image ?? '',
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
