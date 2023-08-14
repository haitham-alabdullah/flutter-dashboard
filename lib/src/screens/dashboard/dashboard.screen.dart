import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/auth.provider.dart';
import '../../widgets/wrapper.widget.dart';

class DashboardScreen extends StatefulWidget {
  static const route = '/';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return WrapperWidget(
      (screen) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.find<AuthProvider>().toggleAuth(false);
                  Get.toNamed('/login');
                },
                child: const Text('logout'),
              ),
            ),
            Text(
              screen.screenType.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
