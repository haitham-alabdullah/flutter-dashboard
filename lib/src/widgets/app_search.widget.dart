import 'package:dashboard/src/providers/search.provider.dart';
import 'package:dashboard/src/widgets/simple_loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/constents.class.dart';
import '../classes/shortcuts.class.dart';

class AppSearch extends StatefulWidget {
  const AppSearch({super.key});

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GetBuilder<SearchProvider>(builder: (provider) {
        return CallbackShortcuts(
          bindings: {escape: provider.clear},
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: provider.searchController,
              onSubmitted: provider.search,
              onChanged: (value) => setState(() {}),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search',
                fillColor: Colors.white,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: provider.isLoading
                      ? const SimpleLoader(
                          size: 20,
                          strokeWidth: 2,
                        )
                      : const Icon(Icons.search_rounded),
                ),
                suffixIcon: provider.searchController.text.isNotEmpty
                    ? InkWell(
                        onTap: provider.clear,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            Icons.cancel_rounded,
                            color: primaryColor,
                          ),
                        ),
                      )
                    : null,
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
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
