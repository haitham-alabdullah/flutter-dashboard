import 'package:dashboard/src/classes/constents.class.dart';
import 'package:dashboard/src/widgets/responsive_widgets/responsive.widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';

import '../../classes/functions.class.dart';
import '../../models/data_table_models/grid_column.model.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget(this.columnNames, {required this.dataRows, super.key});
  final List<GridColumnModel> columnNames;
  final List<DataGridRow> dataRows;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, screen) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey.withOpacity(.1),
          ),
        ),
        child: SfDataGridTheme(
          data: SfDataGridThemeData(
            rowHoverColor: primaryColor.withOpacity(.1),
            headerHoverColor: primaryColor.withOpacity(.1),
            sortIcon: const Icon(
              Icons.arrow_downward_rounded,
              size: 20,
              color: Colors.blueGrey,
            ),
            filterIcon: const Icon(
              Icons.filter_alt_rounded,
              size: 20,
              color: Colors.blueGrey,
            ),
          ),
          child: SfDataGrid(
            rowsPerPage: 30,
            allowFiltering: true,
            allowSorting: true,
            columnWidthMode: ColumnWidthMode.fill,
            showFilterIconOnHover: true,
            rowHeight: 70,
            gridLinesVisibility: GridLinesVisibility.horizontal,
            headerGridLinesVisibility: GridLinesVisibility.both,
            source: TableDataList(
              context,
              data: dataRows,
              isSmallScreen: screen.isSmall,
            ),
            // tableSummaryRows: [
            //   GridTableSummaryRow(
            //     showSummaryInRow: true,
            //     title: 'Total: {Count} User',
            //     columns: [
            //       const GridSummaryColumn(
            //         name: 'Count',
            //         columnName: 'ID',
            //         summaryType: GridSummaryType.count,
            //       )
            //     ],
            //     position: GridTableSummaryRowPosition.bottom,
            //   )
            // ],
            columns: columnNames
                .map(
                  (e) => GridColumn(
                    columnName: e.name,
                    width: e.width,
                    allowFiltering: e.allowFiltering,
                    allowSorting: e.allowSorting,
                    columnWidthMode: e.columnWidthMode,
                    filterIconPadding: EdgeInsets.zero,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Text(
                          e.name,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.blueGrey,
                                  ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    });
  }
}

class TableDataList<T> extends DataGridSource {
  TableDataList(
    BuildContext cnx, {
    required List<DataGridRow> data,
    bool isSmallScreen = false,
  }) {
    context = cnx;
    _usersList = data;
  }

  List<DataGridRow> _usersList = [];
  late BuildContext context;

  @override
  List<DataGridRow> get rows => _usersList;

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(15.0),
      child: SelectableText(
        summaryValue,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey,
            ),
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15.0),
        child: dataGridCell.value is Widget
            ? dataGridCell.value
            : dataGridCell.value is DateTime
                ? SelectableText(
                    formatDate(dataGridCell.value as DateTime),
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                : SelectableText(
                    dataGridCell.value.toString(),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            dataGridCell.value is int ? Colors.blueGrey : null),
                  ),
      );
    }).toList());
  }
}
