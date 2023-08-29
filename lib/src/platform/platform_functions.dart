import 'package:flutter/services.dart';

import '../classes/functions.class.dart';

class PlatformFunctions {
  static void init() {
    try {
      keyListener();
    } catch (e) {
      //
    }
  }

  static keyListener() {
    RawKeyboard.instance.addListener((event) {
      final isKeyDown = event is RawKeyDownEvent;
      if (isKeyDown &&
          event.logicalKey.keyId == 102 &&
          event.isControlPressed) {
        focusSearch();
      }
    });
  }
}
