import 'package:dashboard/src/classes/constents.class.dart';
import 'package:dashboard/src/classes/functions.class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../demo.data.dart';
import '../../classes/enums.class.dart';
import '../../models/data_table_models/grid_column.model.dart';
import '../card.widget.dart';
import '../dialogs/add_user.dialog.dart';
import '../menu_list.widget.dart';
import '../simple_loader.widget.dart';
import 'data_table.widget.dart';
import 'data_table_search.widget.dart';

class DataTableCard extends StatefulWidget {
  const DataTableCard(this.isBig, this.is4K, this.isMobile, {super.key});

  final bool isBig;
  final bool is4K;
  final bool isMobile;

  @override
  State<DataTableCard> createState() => _DataTableCardState();
}

class _DataTableCardState extends State<DataTableCard> {
  bool isLoadingTable = true;

  List<UsersModel> users = [];
  List<UsersModel> filteredUsers = [];

  final searchController = TextEditingController();

  void set(VoidCallback func) => mounted ? setState(func) : null;

  void onTableSearch(String value) {
    if (value.isEmpty) {
      filteredUsers = users.toList();
    } else {
      filteredUsers = users.where((e) {
        return e.id == value ||
            e.name.toLowerCase().contains(value.toLowerCase()) ||
            e.email.toLowerCase().contains(value.toLowerCase()) ||
            e.phone.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }

    set(() {});
  }

  Future<void> getTableData() async {
    set(() => isLoadingTable = true);
    await Future.delayed(const Duration(seconds: 1), () {
      users = demoUsersList;
      filteredUsers = demoUsersList;
      set(() => isLoadingTable = false);
    });
  }

  @override
  void initState() {
    getTableData();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: 700,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: SelectableText(
                  'Users',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                children: [
                  if (!widget.isMobile)
                    DataTableSearchWidget(
                      onChange: onTableSearch,
                      controller: searchController,
                      hint: 'Search Name, Email, Phone',
                    ),
                  const SizedBox(width: 15),
                  IconButton.filledTonal(
                    onPressed: () {},
                    tooltip: 'Export CSV',
                    splashRadius: 25,
                    icon: const Icon(Icons.ios_share_rounded, size: 20),
                  ),
                  const SizedBox(width: 15),
                  IconButton.filledTonal(
                    onPressed: getTableData,
                    tooltip: 'Refresh',
                    splashRadius: 25,
                    icon: isLoadingTable
                        ? const SimpleLoader(
                            size: 20,
                            strokeWidth: 2,
                          )
                        : const Icon(Icons.refresh_rounded, size: 20),
                  ),
                  const SizedBox(width: 15),
                  const IconButton.filledTonal(
                    onPressed: showAddUserDialog,
                    tooltip: 'Add User',
                    splashRadius: 25,
                    icon: Icon(Icons.add_rounded, size: 20),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: isLoadingTable
                ? const Center(child: SimpleLoader())
                : DataTableWidget(
                    [
                      GridColumnModel(
                        name: '#',
                        width: 70,
                        allowFiltering: false,
                        allowSorting: false,
                      ),
                      GridColumnModel(name: 'Name'),
                      if (widget.isBig) GridColumnModel(name: 'Date of birth'),
                      if (widget.isBig) GridColumnModel(name: 'Gender'),
                      GridColumnModel(name: 'Email'),
                      GridColumnModel(name: 'Phone'),
                      GridColumnModel(
                        name: 'Status',
                        allowFiltering: false,
                        allowSorting: false,
                        width: 120,
                      ),
                      GridColumnModel(
                        name: 'Actions',
                        allowFiltering: false,
                        allowSorting: false,
                        columnWidthMode: ColumnWidthMode.lastColumnFill,
                      ),
                    ],
                    dataRows: filteredUsers
                        .map<DataGridRow>(
                          (user) => DataGridRow(
                            cells: [
                              DataGridCell<Widget>(
                                columnName: '#',
                                value: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(user.avatar),
                                ),
                              ),
                              DataGridCell<String>(
                                  columnName: 'Name', value: user.name),
                              if (widget.isBig)
                                DataGridCell<DateTime>(
                                  columnName: 'Date of birth',
                                  value: user.dateOfBirth,
                                ),
                              if (widget.isBig)
                                DataGridCell<String>(
                                    columnName: 'Gender', value: user.gender),
                              DataGridCell<String>(
                                  columnName: 'Email', value: user.email),
                              DataGridCell<String>(
                                  columnName: 'Phone', value: user.phone),
                              DataGridCell<Widget>(
                                columnName: 'Status',
                                value: SizedBox(
                                  height: 30,
                                  child: FittedBox(
                                    child: CupertinoSwitch(
                                      value: user.status,
                                      activeColor: primaryColor,
                                      onChanged: (value) {
                                        user.status = value;

                                        set(() {});
                                        toast(
                                          'User "${user.name}" has been ${value ? 'Activated' : 'Deactivated'}',
                                          type: value
                                              ? ToastType.success
                                              : ToastType.warning,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              DataGridCell<Widget>(
                                columnName: 'Actions',
                                value: widget.is4K
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FittedBox(
                                            child: IconButton(
                                              onPressed: () {},
                                              tooltip: 'Details',
                                              splashRadius: 25,
                                              icon: const Icon(
                                                  Icons.person_outline,
                                                  color: Colors.blueGrey,
                                                  size: 20),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          FittedBox(
                                            child: IconButton(
                                              onPressed: () {},
                                              tooltip: 'Edit',
                                              splashRadius: 25,
                                              icon: const Icon(
                                                  Icons.edit_outlined,
                                                  color: Colors.blueGrey,
                                                  size: 20),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          FittedBox(
                                            child: IconButton(
                                              onPressed: () {},
                                              tooltip: 'Delete Account',
                                              splashRadius: 25,
                                              icon: const Icon(
                                                  Icons.delete_outline_rounded,
                                                  color: Colors.red,
                                                  size: 20),
                                            ),
                                          ),
                                        ],
                                      )
                                    : MenuList(
                                        actions: [
                                          MenuListItem(
                                            callback: () => print(user.id),
                                            svgName: 'profile',
                                            title: 'User Details',
                                          ),
                                          MenuListItem(
                                            callback: () => print(user.name),
                                            svgName: 'menu',
                                            title: 'Details',
                                          ),
                                          MenuListItem(
                                            callback: () => print(user.id),
                                            title: 'Remove',
                                            svgName: 'logout',
                                            color: Colors.redAccent,
                                          ),
                                        ],
                                        offset: const Offset(0, 5),
                                        builder: (controller) => IconButton(
                                          onPressed: () {
                                            if (controller.isOpen) {
                                              controller.close();
                                            } else {
                                              controller.open();
                                            }
                                          },
                                          icon: const Icon(
                                              Icons.more_vert_rounded),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
