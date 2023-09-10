import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GridColumnModel {
  final String name;
  final double width;
  final bool allowFiltering;
  final bool allowSorting;
  final ColumnWidthMode columnWidthMode;

  GridColumnModel({
    required this.name,
    this.width = double.nan,
    this.allowFiltering = true,
    this.allowSorting = true,
    this.columnWidthMode = ColumnWidthMode.none,
  });
}
