import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/enums.class.dart';
import '../widgets/notifications_widgets/alert.widget.dart';

class AlertProvider extends GetxController {
  final Rx<Alert?> _alert = Rx<Alert?>(null);
  Widget? get alert => _alert.value;

  setAlert(String message, {AlertType type = AlertType.info}) {
    _alert.value = Alert(
      message,
      type: type,
      dismissible: true,
      onDismiss: () {
        _alert.value = null;
        update();
      },
    );
    update();
  }
}
