import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/auth.provider.dart';
import '../../widgets/responsive.widget.dart';

class DashboardScreen extends StatefulWidget {
  static const route = '/';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(DashboardScreen.route),
      ),
      drawer: const Drawer(),
      body: ResponsiveWidget(
        desktop: Center(
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
              const Text(
                'desktop',
              ),
            ],
          ),
        ),
        tablet: Center(
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
              const Text(
                'tablet',
              ),
            ],
          ),
        ),
        mobile: Center(
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
              const Text(
                'mobile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
