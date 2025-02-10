import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/common_widget/custom_alert_dialog.dart';
import 'package:prison_foodie_admin/common_widget/custom_text_with_label.dart';
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
          child: DataTable(
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
            dataRowMaxHeight: 60,
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
        DataCell(Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Reject",
                style: TextStyle(color: onprimaryColor),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Approve",
                style: TextStyle(color: onprimaryColor),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    width: 500,
                    title: 'Delivery Partner Details',
                    content: Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const Text(
                            'Delivery Partner Image',
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                height: 150,
                                width: 150,
                                'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Delivery Partner License Image',
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 200,
                              width: 356,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextWithLabel(
                              label: 'Delivery Partner Name', text: 'Subash'),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextWithLabel(label: 'State', text: 'Kerala'),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextWithLabel(
                              label: 'District', text: 'kannur'),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextWithLabel(label: 'Pincode', text: '670456'),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextWithLabel(
                              label: 'AddressLine',
                              text:
                                  'Cccl Building, Jai Singh Road, Connaught Place'),
                        ],
                      ),
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child: const Text("View"),
            ),
          ],
        )),
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
