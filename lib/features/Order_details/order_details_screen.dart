import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/features/Order_details/dummy_order_details.dart';
import 'package:prison_foodie_admin/features/Order_details/order_details_view_screen.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final List<DummyOrderDetails> orderDetailsList = List.from(orderDetails);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Order Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: DataTable(
            headingRowColor: const WidgetStatePropertyAll<Color?>(primaryColor),
            dataRowColor: const WidgetStatePropertyAll<Color?>(onprimaryColor),
            columns: _createColumns(), // Fixed column generation
            rows: _createRows(), // Fixed row generation
            columnSpacing: 12,

            headingTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: onprimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  /// Creates column headers for the table
  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Order ID', style: _headerStyle)),
      const DataColumn(label: Text('User Name', style: _headerStyle)),
      const DataColumn(label: Text('Delivery Boy ID', style: _headerStyle)),
      const DataColumn(label: Text('Delivery Boy Name', style: _headerStyle)),
      const DataColumn(label: Text('Price', style: _headerStyle)),
      const DataColumn(label: Text('Status', style: _headerStyle)),
      const DataColumn(label: Text('Details', style: _headerStyle)),
    ];
  }

  /// Creates rows dynamically from `orderDetailsList`
  List<DataRow> _createRows() {
    return orderDetailsList.map((e) {
      return DataRow(cells: [
        DataCell(Text(e.orderId.toString())),
        DataCell(Text(e.userName)),
        DataCell(Text(e.deliveryBoyId.toString())),
        DataCell(Text(e.deliveryBoyName)),
        DataCell(Text('\$${e.price}')),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _getStatusColor(e.status),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              e.status,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        DataCell(TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderDetailsViewScreen(),
                ));
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue, // Text color
          ),
          child: const Text("View"),
        )), // "View" button
      ]);
    }).toList();
  }

  /// Header text style
  static const TextStyle _headerStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.lightGreen;
      case "Pending":
        return accentColor;

      default:
        return Colors.grey;
    }
  }
}
