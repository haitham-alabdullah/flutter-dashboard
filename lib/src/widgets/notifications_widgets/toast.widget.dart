import 'package:dashboard/src/providers/toast.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastModel {}

class Toasts extends StatefulWidget {
  const Toasts({super.key});

  @override
  State<Toasts> createState() => _ToastsState();
}

class _ToastsState extends State<Toasts> with SingleTickerProviderStateMixin {
  final provider = Get.find<ToastProvider>();

  dismiss(item) {
    print('dismiss triggered');
    provider.removeToast(item);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 10), () {
      provider.addToast(ToastModel());
      provider.addToast(ToastModel());
    });
    return GetBuilder<ToastProvider>(
      builder: (provider) {
        return SingleChildScrollView(
          child: Column(
            children: provider.toasts.map((e) => Toast(e, dismiss)).toList(),
          ),
        );
      },
    );
  }
}

class Toast extends StatelessWidget {
  const Toast(this.item, this.dismiss, {super.key});
  final ToastModel item;
  final void Function(ToastModel) dismiss;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      dismiss(item);
    });
    return Dismissible(
      key: ValueKey(item.hashCode),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          border: Border.fromBorderSide(BorderSide(color: Colors.green)),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
