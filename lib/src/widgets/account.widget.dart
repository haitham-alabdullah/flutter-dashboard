import 'package:dashboard/src/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    required this.desktop,
    super.key,
  });

  final bool desktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: desktop ? 200 : null,
      padding: const EdgeInsets.all(7),
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
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.profile?.name ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
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
            : const CircleAvatar(
                radius: 20,
              );
      }),
    );
  }
}
