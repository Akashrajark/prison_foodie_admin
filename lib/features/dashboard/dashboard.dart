import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_admin/features/Order_details/order_details_screen.dart';
import 'package:prison_foodie_admin/features/dashboard/dashboard_item.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../util/check_login.dart';
import '../../util/format_function.dart';
import 'dashboard_bloc/dashboard_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map _dashboard = {};

  final DashboardBloc _dashboardBloc = DashboardBloc();
  List<Map<String, dynamic>> _orders = [];
  @override
  void initState() {
    checkLogin(context);
    getDashboard();
    super.initState();
  }

  void getDashboard() {
    _dashboardBloc.add(GetAllDashboardEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _dashboardBloc,
      child: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getDashboard();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is DashboardGetSuccessState) {
            _dashboard = state.dashboard;
            _orders = state.dashboard['orders'];
            Logger().w(_dashboard);
            setState(() {});
          } else if (state is DashboardSuccessState) {
            getDashboard();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 10,
                  children: [
                    DashboardItem(
                      iconData: Icons.moped,
                      label: "Total Delivery boys",
                      value: formatValue(_dashboard['total_delivery_boys']),
                    ),
                    DashboardItem(
                      iconData: Icons.add_circle_outline,
                      label: "Total Food Items",
                      value: formatValue(_dashboard['total_food_items']),
                    ),
                    // DashboardItem(
                    //   iconData: Icons.currency_rupee_outlined,
                    //   label: "Total Revenue",
                    //   value: "will be updated later",
                    // ),
                    DashboardItem(
                      iconData: Icons.person,
                      label: "Total Category",
                      value: formatValue(_dashboard['total_categories']),
                    ),
                    DashboardItem(
                      iconData: Icons.done_all,
                      label: "Total orders",
                      value: formatValue(_dashboard['total_orders']),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                if (state is DashboardLoadingState) LinearProgressIndicator(),
                if (state is DashboardGetSuccessState && _orders.isEmpty)
                  Center(
                    child: Text("No Order found!"),
                  ),
                if (state is DashboardGetSuccessState && _orders.isNotEmpty)
                  Expanded(
                    child: DataTable2(
                      headingRowColor:
                          const WidgetStatePropertyAll<Color?>(primaryColor),
                      dataRowColor:
                          const WidgetStatePropertyAll<Color?>(onprimaryColor),
                      columns: _createcolumn(), // Fixed column generation
                      rows: List.generate(
                        _orders.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text(formatValue(_orders[index]['id']))),
                            DataCell(Text(formatValue(
                                _orders[index]['users']?['user_name']))),
                            DataCell(Text(formatValue(
                                _orders[index]['delivery']?['name']))),
                            DataCell(Text(
                                '\$${formatValue(_orders[index]['price'])}')),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: getStatusColor(
                                      formatValue(_orders[index]['status'])),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  formatValue(_orders[index]['status']),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      columnSpacing: 12,

                      headingTextStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: onprimaryColor,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<DataColumn> _createcolumn() {
    return [
      const DataColumn(
        label: Text(
          'Order Id',
          style: TextStyle(
            color: onprimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'User name',
          style: TextStyle(
            color: onprimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Delivery Boy name',
          style: TextStyle(
            color: onprimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Amount',
          style: TextStyle(
            color: onprimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        numeric: true,
      ),
      const DataColumn(
        label: Text(
          'Status',
          style: TextStyle(
            color: onprimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ];
  }
}
