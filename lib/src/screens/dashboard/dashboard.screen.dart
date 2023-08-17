import 'package:dashboard/src/widgets/responsive.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/routes.provider.dart';
import '../../widgets/simple_loader.widget.dart';

class DashboadScreen extends StatefulWidget {
  const DashboadScreen({super.key});

  @override
  State<DashboadScreen> createState() => _DashboadScreenState();
}

class _DashboadScreenState extends State<DashboadScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2), () {}),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: SimpleLoader());
            }
            return ResponsiveWidget(
              builder: (cnx, screen) => SizedBox(
                child: Column(
                  children: [
                    Text(Get.find<RoutesProvider>().arguments.toString()),
                    Text(screen.screenType.toString()),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
