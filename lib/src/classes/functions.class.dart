import 'dart:math';

import 'package:dashboard/src/classes/enums.class.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../providers/routes.provider.dart';
import '../providers/search.provider.dart';
import '../providers/toast.provider.dart';

String imgUrl(String url) {
  if (kIsWeb) return 'images/$url';
  return 'images/$url';
}

Future<bool> storeData(String key, dynamic value) async {
  try {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
    return true;
  } catch (e) {
    return false;
  }
}

Future<dynamic> readData(String key) async {
  try {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key);
  } catch (e) {
    return null;
  }
}

bool validateEmail(String email) {
  return !EmailValidator.validate(email);
}

void showModel(String type) {
  final r = Random.secure().nextInt(5);
  switch (r) {
    case 0:
      Toaster.toast(ToastType.primary.toString(), type: ToastType.primary);
      break;
    case 1:
      Toaster.toast(ToastType.success.toString(), type: ToastType.success);
      break;
    case 2:
      Toaster.toast(ToastType.warning.toString(), type: ToastType.warning);
      break;
    case 3:
      Toaster.toast(ToastType.danger.toString(), type: ToastType.danger);
      break;
    case 4:
      Toaster.toast(ToastType.info.toString(), type: ToastType.info);
      break;
    default:
      Toaster.toast(ToastType.primary.toString(), type: ToastType.primary);
  }
  // Get.defaultDialog(content: SelectableText(type));
}

void initializeProviders() {
  Get.put(RoutesProvider());
  Get.put(SearchProvider());
  Get.put(ToastProvider());
}
