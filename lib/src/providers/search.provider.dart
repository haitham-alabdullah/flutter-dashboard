import 'package:dashboard/src/classes/enums.class.dart';
import 'package:dashboard/src/models/general_search.model.dart';
import 'package:dashboard/src/providers/toast.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/search/general_search.screen.dart';
import 'routes.provider.dart';

class SearchProvider extends GetxController {
  final searchController = TextEditingController();
  final RxBool _isLoading = RxBool(false);

  bool get isLoading => _isLoading.value;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void loading(bool value) {
    _isLoading.value = value;
    update();
  }

  search(String value) async {
    if (searchController.text.isEmpty) return;
    loading(true);
    await Future.delayed(const Duration(seconds: 1), () {
      if (value.toLowerCase() == 'test') {
        Routes.to(() => const GeneralSerch(<GeneralSearchModel>[]));
      } else {
        Toaster.toast(
          '$value Not found',
          type: ToastType.warning,
          callback: () => print('clicked'),
        );
      }
    });
    searchController.clear();
    loading(false);
  }

  void clear() {
    FocusScope.of(Get.context as BuildContext).unfocus();
    searchController.clear();
    update();
  }
}
