import 'package:dashboard/src/classes/constents.class.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../demo.data.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({super.key});

  List<String> columnList() {
    return [
      'ID',
      'Avatar',
      'Name',
      'Date of birth',
      'Gender',
      'Email',
      'Phone',
      'Actions'
    ];
  }

  double getWidth(e) {
    if (e == 'ID') return 100;
    if (e == 'Avatar') return 70;
    return double.nan;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: Colors.blueGrey,
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
            rowHeight: 80,
            gridLinesVisibility: GridLinesVisibility.horizontal,
            headerGridLinesVisibility: GridLinesVisibility.both,
            source: TableDataList(context, users: demoUsersList),
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
            columns: columnList()
                .map(
                  (e) => GridColumn(
                    columnName: e,
                    width: getWidth(e),
                    allowFiltering:
                        e != 'ID' && e != 'Avatar' && e != 'Actions',
                    allowSorting: e != 'Avatar' && e != 'Actions',
                    columnWidthMode: e == 'ID' || e == 'Avatar'
                        ? ColumnWidthMode.none
                        : ColumnWidthMode.none,
                    filterIconPadding: EdgeInsets.zero,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          e,
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
      ),
    );
  }
}

class TableDataList extends DataGridSource {
  TableDataList(BuildContext cnx, {required List<UsersModel> users}) {
    context = cnx;
    _usersList = users
        .map<DataGridRow>(
          (user) => DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'ID', value: int.parse(user.id)),
              DataGridCell<Widget>(
                columnName: 'Avatar',
                value: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(user.avatar),
                ),
              ),
              DataGridCell<String>(columnName: 'Name', value: user.name),
              DataGridCell<DateTime>(
                columnName: 'Date of birth',
                value: user.dateOfBirth.toLocal(),
              ),
              DataGridCell<Gender>(columnName: 'Gender', value: user.gender),
              DataGridCell<String>(columnName: 'Email', value: user.email),
              DataGridCell<String>(columnName: 'Phone', value: user.phone),
              DataGridCell<String>(columnName: 'Actions', value: user.id),
            ],
          ),
        )
        .toList();
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
      child: Text(
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
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.value is Widget
            ? dataGridCell.value
            : Text(
                dataGridCell.value.toString(),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: dataGridCell.value is int ? Colors.blueGrey : null),
              ),
      );
    }).toList());
  }
}
