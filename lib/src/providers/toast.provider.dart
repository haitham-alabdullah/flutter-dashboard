import 'package:get/get.dart';

import '../widgets/notifications_widgets/toast.widget.dart';

class ToastProvider extends GetxController {
  final List<ToastModel> _toasts = [
    ToastModel(),
    ToastModel(),
    ToastModel(),
    ToastModel(),
    ToastModel(),
    ToastModel(),
  ];

  List<ToastModel> get toasts => _toasts;

  addToast(item) {
    _toasts.add(item);
    update();
  }

  removeToast(item) {
    _toasts.remove(item);
    update();
  }
}
