import 'package:flutter/material.dart';

import '../../models/general_search.model.dart';

class GeneralSerch extends StatelessWidget {
  static const route = '/search';
  const GeneralSerch(this.result, {super.key});

  final List<GeneralSearchModel> result;

  @override
  Widget build(BuildContext context) {
    return Text(result.toString());
  }
}
