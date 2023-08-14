import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/auth.provider.dart';

class Error404Screen extends StatelessWidget {
  const Error404Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
          const Text('error NOT found'),
        ],
      ),
    );
  }
}
