import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String imgUrl(String url) {
  if (kIsWeb) return '/images/$url';
  return 'assets/images/$url';
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
