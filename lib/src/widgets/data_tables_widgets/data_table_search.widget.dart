import 'package:flutter/material.dart';

import '../../classes/constents.class.dart';
import '../../classes/shortcuts.class.dart';

class DataTableSearchWidget extends StatelessWidget {
  const DataTableSearchWidget(
      {required this.controller, required this.onChange, this.hint, super.key});

  final TextEditingController controller;
  final void Function(String) onChange;
  final String? hint;

  clear() {
    controller.clear();
    onChange('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: CallbackShortcuts(
        bindings: {escape: clear},
        child: TextField(
          controller: controller,
          onSubmitted: onChange,
          onChanged: onChange,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: hint ?? 'Search',
            hintStyle: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.blueGrey),
            fillColor: Colors.white,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(15),
              child: Icon(Icons.search_rounded),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: controller.text.isNotEmpty,
                  child: InkWell(
                    onTap: clear,
                    child: const Icon(
                      Icons.cancel_rounded,
                      color: primaryColor,
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.text.isNotEmpty,
                  child: const SizedBox(width: 15),
                ),
              ],
            ),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor.withOpacity(.1),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
