import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_admin/common_widget/custom_button.dart';
import 'package:prison_foodie_admin/common_widget/custom_search.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';
import 'package:prison_foodie_admin/util/format_function.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../util/check_login.dart';
import 'orders_bloc/orders_bloc.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final OrdersBloc _ordersBloc = OrdersBloc();

  Map<String, dynamic> params = {
    'query': null,
    'status': null,
  };

  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    checkLogin(context);
    getOrders();
    super.initState();
  }

  void getOrders() {
    _ordersBloc.add(GetAllOrdersEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _ordersBloc,
      child: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {
          if (state is OrdersFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getOrders();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is OrdersGetSuccessState) {
            _orders = state.orders;
            Logger().w(_orders);
            setState(() {});
          } else if (state is OrdersSuccessState) {
            getOrders();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Order Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: CustomSearch(onSearch: (query) {
                        params['query'] = query;
                        getOrders();
                      }),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                if (state is OrdersLoadingState) LinearProgressIndicator(),
                if (state is OrdersGetSuccessState && _orders.isEmpty)
                  Center(
                    child: Text("No Order found!"),
                  ),
                if (state is OrdersGetSuccessState && _orders.isNotEmpty)
                  Expanded(
                    child: DataTable2(
                      headingRowColor:
                          const WidgetStatePropertyAll<Color?>(primaryColor),
                      dataRowColor:
                          const WidgetStatePropertyAll<Color?>(onprimaryColor),
                      columns: _createColumns(), // Fixed column generation
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
                            DataCell(CustomButton(
                              onPressed: () {},
                              label: 'View',
                            )),
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

  /// Creates column headers for the table
  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Order ID', style: _headerStyle)),
      const DataColumn(label: Text('User Name', style: _headerStyle)),
      const DataColumn(label: Text('Delivery Boy Name', style: _headerStyle)),
      const DataColumn(label: Text('Price', style: _headerStyle)),
      const DataColumn(label: Text('Status', style: _headerStyle)),
      const DataColumn(label: Text('Items', style: _headerStyle)),
    ];
  }

  /// Header text style
  static const TextStyle _headerStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
}

Color getStatusColor(String status) {
  switch (status) {
    case "Delivered":
      return Colors.lightGreen;
    case "Pending":
      return accentColor;

    default:
      return Colors.grey;
  }
}
