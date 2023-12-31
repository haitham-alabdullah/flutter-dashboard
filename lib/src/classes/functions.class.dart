import 'dart:math';

import 'package:dashboard/src/classes/constents.class.dart';
import 'package:dashboard/src/classes/enums.class.dart';
import 'package:dashboard/src/classes/routes.class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

alert(
  String message, {
  AlertType type = AlertType.primary,
  Duration autoDismissAfter = Duration.zero,
}) {
  Get.find<AlertProvider>().setAlert(
    message,
    type: type,
    autoDismissAfter: autoDismissAfter,
  );
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
      alert(AlertType.primary.toString(), type: AlertType.primary);
      break;
    case 1:
      alert(AlertType.success.toString(), type: AlertType.success);
      break;
    case 2:
      alert(AlertType.warning.toString(), type: AlertType.warning);
      break;
    case 3:
      alert(AlertType.danger.toString(), type: AlertType.danger);
      break;
    case 4:
      alert(AlertType.info.toString(), type: AlertType.info);
      break;
    default:
      alert(AlertType.primary.toString(), type: AlertType.primary);
  }
  // Get.defaultDialog(content: SelectableText(type));
}

Future<void> initializeProviders() async {
  Get.put(AuthProvider(), permanent: true);
  Get.put(AlertProvider(), permanent: true);
  Get.put(RoutesProvider());
  Get.put(SearchProvider());
  Get.put(ToastProvider());
}

Future<void> removeProviders() async {
  await Get.delete<RoutesProvider>(force: true);
  await Get.delete<SearchProvider>(force: true);
  await Get.delete<ToastProvider>(force: true);
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

String formatDateTime(DateTime value) {
  int hours = value.hour;
  String letters = 'AM';
  if (hours > 12) {
    hours -= 12;
    letters = "PM";
  }
  String convertedDateTime = value.year.toString();
  convertedDateTime += "-${value.month.toString().padLeft(2, '0')}";
  convertedDateTime += "-${value.day.toString().padLeft(2, '0')}";
  convertedDateTime += "   ${hours.toString().padLeft(2, '0')}";
  convertedDateTime += "-${value.minute.toString().padLeft(2, '0')} $letters";
  return convertedDateTime;
}

String formatDate(DateTime value) {
  String convertedDateTime = value.year.toString();
  convertedDateTime += "-${value.month.toString().padLeft(2, '0')}";
  convertedDateTime += "-${value.day.toString().padLeft(2, '0')}";
  return convertedDateTime;
}
