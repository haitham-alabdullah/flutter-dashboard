import 'package:dashboard/src/providers/search.provider.dart';
import 'package:dashboard/src/widgets/simple_loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/constents.class.dart';
import '../../classes/shortcuts.class.dart';

class AppSearch extends StatefulWidget {
  const AppSearch({super.key});

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  final provider = Get.find<SearchProvider>();

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        escape: provider.clear,
        controlF: provider.focus,
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
        child: TextField(
          controller: provider.searchController,
          focusNode: provider.node,
          onTapOutside: (e) => provider.unfocus(),
          onSubmitted: provider.search,
          onChanged: (value) => setState(() {}),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search',
            fillColor: Colors.white,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: GetBuilder<SearchProvider>(
                builder: (provider) {
                  return provider.isLoading
                      ? const SimpleLoader(
                          size: 20,
                          strokeWidth: 2,
                        )
                      : const Icon(Icons.search_rounded);
                },
              ),
            ),
            suffixIcon: GetBuilder<SearchProvider>(
              builder: (provider) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: provider.searchController.text.isEmpty,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0x77EFEFEF),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          'Ctrl + F',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF616162),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Visibility(
                      visible: provider.searchController.text.isNotEmpty,
                      child: InkWell(
                        onTap: provider.clear,
                        child: const Icon(
                          Icons.cancel_rounded,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: provider.searchController.text.isNotEmpty,
                      child: const SizedBox(width: 15),
                    ),
                  ],
                );
              },
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
