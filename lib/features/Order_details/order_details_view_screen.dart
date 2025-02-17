import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/common_widget/custom_item_list.dart';
import 'package:prison_foodie_admin/common_widget/custom_text_with_label.dart';

class OrderDetailsViewScreen extends StatelessWidget {
  const OrderDetailsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWithLabel(label: 'Customer Name', text: 'Shegharan'),
                      SizedBox(
                        height: 20,
                      ),
                      TextWithLabel(label: 'OrderId', text: '#45222'),
                      SizedBox(
                        height: 20,
                      ),
                      TextWithLabel(
                          label: 'Delivering Address',
                          text:
                              '2nd Floor,flt-8, Pl No-53, Gitanjali Building, Nehru Road, Vile Parle (west)'),
                      SizedBox(
                        height: 20,
                      ),
                      TextWithLabel(label: 'Phone No.', text: '9456554666')
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWithLabel(
                          label: 'Delivery Partner Name', text: 'Joshua'),
                      SizedBox(
                        height: 20,
                      ),
                      TextWithLabel(label: 'Worker Id', text: '#46465'),
                      SizedBox(
                        height: 20,
                      ),
                      TextWithLabel(label: 'Status', text: 'Pending'),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TextWithLabel(label: 'Items Ordersd', text: '5'),
              SizedBox(
                height: 300,
                width: 300,
                child: ListView.separated(
                  itemBuilder: (context, index) => const CustomItemList(),
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
