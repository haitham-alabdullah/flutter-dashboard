import 'package:dashboard/src/classes/constents.class.dart';
import 'package:dashboard/src/classes/enums.class.dart';
import 'package:dashboard/src/classes/functions.class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showAddUserDialog() async {
  bool ifSuccess() {
    Get.back();
    alert(
      'User has been added !!',
      type: AlertType.success,
      autoDismissAfter: const Duration(seconds: 4),
    );
    return true;
  }

  bool ifFiled() {
    return false;
  }

  return await Get.defaultDialog<bool>(
    title: 'Add User',
    backgroundColor: Colors.white,
    buttonColor: primaryColor,
    content: const AddUserDialogWidget(),
    onConfirm: ifSuccess,
    onCancel: ifFiled,
  ).then((value) {
    return value ?? false ? ifSuccess() : ifFiled();
  });
}

class AddUserDialogWidget extends StatelessWidget {
  const AddUserDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      height: Get.height - 300,
      color: Colors.white,
      child: const SingleChildScrollView(),
    );
  }
}
