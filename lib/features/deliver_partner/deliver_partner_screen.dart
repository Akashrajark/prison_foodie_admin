import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/features/deliver_partner/dummy_delivery_boy_data.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';

class DeliverPartnerScreen extends StatefulWidget {
  const DeliverPartnerScreen({super.key});

  @override
  State<DeliverPartnerScreen> createState() => _DeliverPartnerScreenState();
}

class _DeliverPartnerScreenState extends State<DeliverPartnerScreen> {
  final List<DummyDeliveryBoyData> _details = List.from(deliveryDetail);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Delivery Partner Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: DataTable2(
            headingRowColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                return primaryColor; // Default row color (light grey)
              },
            ),
            dataRowColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                return onprimaryColor; // Default row color (light grey)
              },
            ),
            columns: _createColumns(),
            rows: _createRows(),
            columnSpacing: 12,
            dataRowHeight: 60,
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

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label: Text(
        'ID',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Name',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Email',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Status',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Action',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
    ];
  }

  List<DataRow> _createRows() {
    return _details.map((e) {
      return DataRow(cells: [
        DataCell(Text(e.id.toString())),
        DataCell(Text(e.name)),
        DataCell(Text(e.email)),
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
        DataCell(e.action),
      ]);
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.lightGreen;
      case "Pending":
        return accentColor;
      case "Rejected":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }
}
