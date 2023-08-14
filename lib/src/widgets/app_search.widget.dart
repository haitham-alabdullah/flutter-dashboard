import 'package:dashboard/src/widgets/simple_loader.widget.dart';
import 'package:flutter/material.dart';

import '../classes/constents.class.dart';

class AppSearch extends StatefulWidget {
  const AppSearch({super.key});

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  final searchController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  update(VoidCallback func) {
    if (mounted) setState(func);
  }

  search(String value) async {
    if (value.isEmpty) return;
    update(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1), () {});
    searchController.clear();
    update(() => isLoading = false);
  }

  clear() {
    FocusScope.of(context).unfocus();
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: TextField(
          controller: searchController,
          onSubmitted: search,
          onChanged: (value) => update(() {}),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search',
            fillColor: Colors.white,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: isLoading
                  ? const SimpleLoader(
                      size: 20,
                      strokeWidth: 2,
                    )
                  : const Icon(Icons.search_rounded),
            ),
            suffixIcon: searchController.text.isNotEmpty
                ? InkWell(
                    onTap: clear,
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
  }
}
