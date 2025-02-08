import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/features/dashboard/dashboard_item.dart';
import 'package:prison_foodie_admin/features/dashboard/dummydata.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<RecentOrders> _orders = List.from(orders);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 10,
          children: [
            DashboardItem(
              iconData: Icons.moped,
              label: "Total Delivery boys",
              value: '',
            ),
            DashboardItem(
              iconData: Icons.add_circle_outline,
              label: "Active Delivery",
              value: '',
            ),
            DashboardItem(
              iconData: Icons.currency_rupee_outlined,
              label: "Total Revenue",
              value: '',
            ),
            DashboardItem(
              iconData: Icons.person,
              label: "Total Users",
              value: '',
            ),
            DashboardItem(
              iconData: Icons.done_all,
              label: "Completed orders",
              value: '',
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
        Expanded(
          child: DataTable(
            headingRowColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                return primaryColor;
              },
            ),
            dataRowColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                return onprimaryColor;
              },
            ),
            columnSpacing: 12,
            dividerThickness: 1,
            headingRowHeight: 40,
            dataRowMinHeight: 40,
            dataRowMaxHeight: 40,
            columns: _createcolumn(),
            rows: _createRow(),
          ),
        ),
      ],
    );
  }

  List<DataColumn> _createcolumn() {
    return [
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
          'Invoice',
          style: TextStyle(
            color: onprimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Invoice Date',
          style: TextStyle(
            color: onprimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
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
      const DataColumn(
          label: Text(
            'Amount',
            style: TextStyle(
              color: onprimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          numeric: true),
    ];
  }

  List<DataRow> _createRow() {
    return _orders.map((e) {
      return DataRow(
        cells: [
          DataCell(Text(e.user)),
          DataCell(Text(e.orderId.toString())),
          DataCell(Text(e.deliveryboyname)),
          DataCell(Text(e.invoice)),
          DataCell(Text(e.invoicedate)),
          DataCell(Text(e.status)),
          DataCell(
            Text(
              e.amount.toString(),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      );
    }).toList();
  }
}
