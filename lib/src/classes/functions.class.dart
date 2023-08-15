import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  Get.defaultDialog(content: SelectableText(type));
}

void initializeProviders() {
  Get.put(RoutesProvider());
  Get.put(SearchProvider());
  Get.put(ToastProvider());
}
