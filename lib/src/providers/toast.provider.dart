import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/constents.class.dart';
import '../classes/enums.class.dart';
import '../widgets/notifications_widgets/toast.widget.dart';

class Toaster {
  static toast(
    String? message, {
    ToastType type = ToastType.primary,
    VoidCallback? callback,
  }) {
    Get.find<ToastProvider>().addToast(message, type: type, callback: callback);
  }
}

class ToastProvider extends GetxController {
  late GlobalKey<AnimatedListState> listKey;

  setKey(GlobalKey<AnimatedListState> key) {
    listKey = key;
  }

  final List<ToastModel> _toasts = [];

  List<ToastModel> get toasts => _toasts;

  addToast(String? message,
      {ToastType type = ToastType.primary, VoidCallback? callback}) {
    final item = ToastModel(type: type, message: message, callback: callback);
    _toasts.insert(0, item);
    listKey.currentState?.insertItem(0, duration: toastDuration);
    update();
  }

  removeToast(ToastModel item, DissmissType type) {
    try {
      final index = _toasts.indexOf(item);
      _toasts.removeAt(index);
      listKey.currentState?.removeItem(
        index,
        (__, _) =>
            type == DissmissType.swipe ? const SizedBox() : buildItem(item, _),
        duration: toastDuration,
      );
      update();
    } catch (e) {
      //
    }
  }

  Widget buildItem(ToastModel item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Toast(item, removeToast),
      ),
    );
  }
}
