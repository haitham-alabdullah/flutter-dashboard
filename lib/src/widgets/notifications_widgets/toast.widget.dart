import 'package:dashboard/src/providers/toast.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/constents.class.dart';
import '../../classes/enums.class.dart';

class ToastModel {
  final String? message;
  final ToastType type;
  final VoidCallback? callback;

  ToastModel({
    this.message,
    this.callback,
    this.type = ToastType.primary,
  });

  Color get color => getColor();
  IconData get icon => getIcon();

  Color getColor() {
    switch (type) {
      case ToastType.success:
        return Colors.green;
      case ToastType.danger:
        return Colors.red;
      case ToastType.warning:
        return Colors.amber;
      case ToastType.info:
        return Colors.blue;
      default:
        return primaryColor;
    }
  }

  IconData getIcon() {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle_rounded;
      case ToastType.danger:
        return Icons.cancel_rounded;
      case ToastType.warning:
        return Icons.warning_rounded;
      case ToastType.info:
        return Icons.info_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }
}

class Toasts extends StatefulWidget {
  const Toasts({super.key});

  @override
  State<Toasts> createState() => _ToastsState();
}

class _ToastsState extends State<Toasts> {
  final listKey = GlobalKey<AnimatedListState>();
  final provider = Get.find<ToastProvider>();

  @override
  void initState() {
    provider.setKey(listKey);
    super.initState();
  }

  final slideInTween =
      Tween<Offset>(begin: const Offset(3, 0), end: Offset.zero);

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      itemBuilder: (cnx, i, _) => provider.buildItem(provider.toasts[i], _),
    );
  }
}

class Toast extends StatelessWidget {
  const Toast(this.item, this.dismiss, {super.key});
  final ToastModel item;
  final void Function(ToastModel, DissmissType) dismiss;

  @override
  Widget build(BuildContext context) {
    final color = item.color;
    if (toastAutoDissmiss) {
      Future.delayed(
              toastDissmissDuration, () => dismiss(item, DissmissType.auto))
          .catchError((e) {});
    }
    return Dismissible(
      key: ValueKey(item.hashCode),
      onDismissed: (_) => dismiss(item, DissmissType.swipe),
      confirmDismiss: (direction) async {
        return direction == DismissDirection.startToEnd;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: item.callback,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              border: Border.fromBorderSide(BorderSide(color: color)),
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: color,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(item.message ?? ''),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => dismiss(item, DissmissType.click),
                  splashColor: Colors.transparent,
                  child: const Icon(
                    Icons.close_rounded,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
