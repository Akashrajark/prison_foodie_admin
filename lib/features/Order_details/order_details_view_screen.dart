// import 'package:flutter/material.dart';
// import 'package:prison_foodie_admin/common_widget/custom_item_list.dart';
// import 'package:prison_foodie_admin/common_widget/custom_text_with_label.dart';

// class OrderDetailsViewScreen extends StatelessWidget {
//   const OrderDetailsViewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//           child: ListView(
//             shrinkWrap: true,
//             children: [
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextWithLabel(label: 'Customer Name', text: 'Shegharan'),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       TextWithLabel(label: 'OrderId', text: '#45222'),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       TextWithLabel(
//                           label: 'Delivering Address',
//                           text:
//                               '2nd Floor,flt-8, Pl No-53, Gitanjali Building, Nehru Road, Vile Parle (west)'),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       TextWithLabel(label: 'Phone No.', text: '9456554666')
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextWithLabel(
//                           label: 'Delivery Partner Name', text: 'Joshua'),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       TextWithLabel(label: 'Worker Id', text: '#46465'),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       TextWithLabel(label: 'Status', text: 'Pending'),
//                     ],
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const TextWithLabel(label: 'Items Ordersd', text: '5'),
//               SizedBox(
//                 height: 300,
//                 width: 300,
//                 child: ListView.separated(
//                   itemBuilder: (context, index) => const CustomItemList(),
//                   itemCount: 5,
//                   separatorBuilder: (context, index) => const SizedBox(
//                     height: 20,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/common_widget/width_bound.dart';

import '../../util/format_function.dart';

class OrderDetail extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetail({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order['id']}'),
      ),
      body: WidthBound(
        width: 700,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Text(
                          '\$${formatInteger(order['price'])}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Date',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Text(
                          formatDate(order['created_at']),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Status',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Text(
                          order['status'],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: () {
                              switch (order['status'].toLowerCase()) {
                                case 'pending':
                                  return Colors.orange;
                                case 'delivered':
                                  return Colors.green;
                                case 'cancelled':
                                  return Colors.red;
                                default:
                                  return Colors.grey;
                              }
                            }(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Items',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...order['items'].map<Widget>((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['food']['image_url'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.fastfood),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['food']['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    item['food']['description'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'x${item['count']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (order['deliver_partner_id'] != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Partner',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          Text(
                            order['deliveryGuy']['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    const Text(
                      'No delivery partner assigned yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
