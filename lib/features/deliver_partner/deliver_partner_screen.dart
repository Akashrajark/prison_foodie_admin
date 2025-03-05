import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_admin/common_widget/custom_search.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';
import 'package:prison_foodie_admin/util/format_function.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../util/check_login.dart';
import 'delivery_partners_bloc/delivery_partners_bloc.dart';

class DeliverPartnerScreen extends StatefulWidget {
  const DeliverPartnerScreen({super.key});

  @override
  State<DeliverPartnerScreen> createState() => _DeliverPartnerScreenState();
}

class _DeliverPartnerScreenState extends State<DeliverPartnerScreen> {
  final DeliveryPartnersBloc _deliveryPartnersBloc = DeliveryPartnersBloc();

  Map<String, dynamic> params = {'query': null, 'status': 'Pending'};
  String _selectedStatus = "Pending";

  List<Map> _deliveryPartners = [];

  @override
  void initState() {
    checkLogin(context);
    getDeliveryPartners();
    super.initState();
  }

  void getDeliveryPartners() {
    _deliveryPartnersBloc.add(GetAllDeliveryPartnersEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _deliveryPartnersBloc,
      child: BlocConsumer<DeliveryPartnersBloc, DeliveryPartnersState>(
        listener: (context, state) {
          if (state is DeliveryPartnersFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getDeliveryPartners();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is DeliveryPartnersGetSuccessState) {
            _deliveryPartners = state.deliveryPartners;
            Logger().w(_deliveryPartners);
            setState(() {});
          } else if (state is DeliveryPartnersSuccessState) {
            getDeliveryPartners();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Delivery Partner Details',
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
                        getDeliveryPartners();
                      }),
                    ),
                    CupertinoSegmentedControl<String>(
                      padding: const EdgeInsets.all(16),
                      groupValue: _selectedStatus,
                      onValueChanged: (String value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                        params['status'] = _selectedStatus;
                        getDeliveryPartners();
                      },
                      children: const {
                        "Pending": Padding(
                            padding: EdgeInsets.all(8), child: Text("Pending")),
                        "Rejected": Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Rejected")),
                        "Approved": Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Approved")),
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (state is DeliveryPartnersLoadingState)
                  LinearProgressIndicator(),
                if (state is DeliveryPartnersGetSuccessState &&
                    _deliveryPartners.isEmpty)
                  Center(
                    child: Text("No delivery partner found!"),
                  ),
                if (state is DeliveryPartnersGetSuccessState &&
                    _deliveryPartners.isNotEmpty)
                  Expanded(
                    child: DataTable2(
                      columnSpacing: 12,
                      dataRowHeight: 60,
                      headingTextStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: onprimaryColor,
                      ),
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
                      rows: List.generate(
                        _deliveryPartners.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text(
                                _deliveryPartners[index]['id'].toString())),
                            DataCell(Text(_deliveryPartners[index]['name'])),
                            DataCell(Text(_deliveryPartners[index]['email'])),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(
                                      _deliveryPartners[index]['status']),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  _deliveryPartners[index]['status'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  if (_deliveryPartners[index]['status'] ==
                                      'Pending')
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => CustomAlertDialog(
                                            title:
                                                'Reject ${_deliveryPartners[index]['name']}?',
                                            description:
                                                'Are you sure you want to reject ${_deliveryPartners[index]['name']}? This action cannot be undone.',
                                            primaryButton: 'Reject',
                                            onPrimaryPressed: () {
                                              BlocProvider.of<
                                                          DeliveryPartnersBloc>(
                                                      context)
                                                  .add(
                                                EditDeliveryPartnerEvent(
                                                  deliveryPartnerDetails: {
                                                    'status': 'Rejected'
                                                  },
                                                  deliveryPartnerId:
                                                      _deliveryPartners[index]
                                                          ['id'],
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            secondaryButton: 'Cancel',
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: const Text(
                                        "Reject",
                                        style: TextStyle(color: onprimaryColor),
                                      ),
                                    ),
                                  const SizedBox(width: 8),
                                  if (_deliveryPartners[index]['status'] ==
                                      'Pending')
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => CustomAlertDialog(
                                            title:
                                                'Approve ${_deliveryPartners[index]['name']}?',
                                            description:
                                                'Are you sure you want to approve ${_deliveryPartners[index]['name']}? They will be able to start deliveries once approved.',
                                            primaryButton: 'Approve',
                                            onPrimaryPressed: () {
                                              BlocProvider.of<
                                                          DeliveryPartnersBloc>(
                                                      context)
                                                  .add(
                                                EditDeliveryPartnerEvent(
                                                  deliveryPartnerDetails: {
                                                    'status': 'Approved'
                                                  },
                                                  deliveryPartnerId:
                                                      _deliveryPartners[index]
                                                          ['id'],
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            secondaryButton: 'Cancel',
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.lightGreen,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                        builder: (_) => CustomAlertDialog(
                                          width: 300,
                                          title: 'Delivery Partner Details',
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage: NetworkImage(
                                                  _deliveryPartners[index]
                                                      ['image_url'],
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                'Name: ${_deliveryPartners[index]['name']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                'Email: ${_deliveryPartners[index]['email']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                'Status: ${_deliveryPartners[index]['status']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Image.network(
                                                _deliveryPartners[index]
                                                    ['license_url'],
                                                height: 200,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                'Vehicle No: ${_deliveryPartners[index]['vehicle_no']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                'Address: ${formatAddress(_deliveryPartners[index])}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          primaryButton: 'Close',
                                          onPrimaryPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          Colors.blue, // Text color
                                    ),
                                    child: const Text("View"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
