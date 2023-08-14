import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    await Future.delayed(const Duration(seconds: 1), () {});
    searchController.clear();
    loading(false);
  }

  void clear() {
    FocusScope.of(Get.context as BuildContext).unfocus();
    searchController.clear();
    update();
  }
}
