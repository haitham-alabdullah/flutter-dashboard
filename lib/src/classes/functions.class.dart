import 'dart:math';

import 'package:dashboard/src/classes/constents.class.dart';
import 'package:dashboard/src/classes/enums.class.dart';
import 'package:dashboard/src/classes/routes.class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../providers/alert.provider.dart';
import '../providers/auth.provider.dart';
import '../providers/routes.provider.dart';
import '../providers/search.provider.dart';
import '../providers/toast.provider.dart';

String imgUrl(String url) {
  if (kIsWeb) return 'images/$url';
  return 'images/$url';
}

Widget svg(String name, {double size = 20, Color? color}) {
  try {
    final String assetName = 'images/svgs/$name.svg';
    return SvgPicture.asset(
      assetName,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? primaryColor, BlendMode.srcIn),
    );
  } catch (e) {
    //
  }
  return const SizedBox();
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

alert(
  String message, {
  AlertType type = AlertType.primary,
  Duration dissmissDuration = Duration.zero,
}) {
  Get.find<AlertProvider>()
      .setAlert(message, type: type, dissmissDuration: dissmissDuration);
}

toast(
  String? message, {
  ToastType type = ToastType.primary,
  VoidCallback? callback,
}) {
  Get.find<ToastProvider>().addToast(message, type: type, callback: callback);
}

void showModel(String type) {
  final r = Random.secure().nextInt(5);
  switch (r) {
    case 0:
      toast(ToastType.primary.toString(), type: ToastType.primary);
      break;
    case 1:
      toast(ToastType.success.toString(), type: ToastType.success);
      break;
    case 2:
      toast(ToastType.warning.toString(), type: ToastType.warning);
      break;
    case 3:
      toast(ToastType.danger.toString(), type: ToastType.danger);
      break;
    case 4:
      toast(ToastType.info.toString(), type: ToastType.info);
      break;
    default:
      toast(ToastType.primary.toString(), type: ToastType.primary);
  }
  // Get.defaultDialog(content: SelectableText(type));
}

void initializeProviders() {
  Get.put(AuthProvider(), permanent: true);
  Get.put(RoutesProvider());
  Get.put(SearchProvider());
  Get.put(ToastProvider());
  Get.put(AlertProvider());
}

Future<void> removeProviders() async {
  await Get.delete<RoutesProvider>(force: true);
  await Get.delete<SearchProvider>(force: true);
  await Get.delete<ToastProvider>(force: true);
  await Get.delete<AlertProvider>(force: true);
}

closeDrawerMenu(String item) {
  for (var child in drawerMenu) {
    if (child.type == DrawerItemType.menu) {
      child.isOpen = false;
      for (var subChild in child.children) {
        if (subChild.route == item) {
          child.isOpen = true;
        } else if (subChild.type == DrawerItemType.menu) {
          subChild.isOpen = false;
          for (var subsubChild in subChild.children) {
            if (subsubChild.route == item) {
              child.isOpen = true;
              subChild.isOpen = true;
            }
          }
        }
      }
    }
  }
}

int menuIndex(String item) {
  for (var child in drawerMenu) {
    if (child.type == DrawerItemType.menu) {
      for (var subChild in child.children) {
        if (subChild.type == DrawerItemType.menu) {
          for (var subsubChild in subChild.children) {
            if (subsubChild.route == item) {
              return drawerMenu.indexOf(child);
            }
          }
        } else {
          if (subChild.route == item) {
            return drawerMenu.indexOf(child);
          }
        }
      }
    } else {
      if (child.route == item) {
        return drawerMenu.indexOf(child);
      }
    }
  }
  return 0;
}

void focusSearch() {
  Get.find<SearchProvider>().focus();
}
