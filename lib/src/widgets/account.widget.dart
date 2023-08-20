import 'package:dashboard/src/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/functions.class.dart';
import '../providers/routes.provider.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    required this.desktop,
    super.key,
  });

  final bool desktop;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      alignmentOffset: const Offset(0, 15),
      menuChildren: [
        SizedBox(
          width: 200,
          child: MenuItemButton(
            onPressed: () => Routes.toNamed('/settings/account'),
            trailingIcon: svg('profile', size: 16, color: Colors.blueGrey),
            child: Text(
              'Profile',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: MenuItemButton(
            onPressed: Get.find<AuthProvider>().logout,
            trailingIcon: svg('logout', size: 16, color: Colors.blueGrey),
            child: Text(
              'Logout',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ],
      style: MenuStyle(
        shape: MaterialStateProperty.all(
          const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        alignment: Alignment.bottomLeft,
      ),
      builder: (_, controller, __) => GestureDetector(
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
