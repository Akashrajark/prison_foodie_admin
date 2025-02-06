import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/common_widget/custom_button.dart';
import 'package:prison_foodie_admin/features/food_item/Dummy_food_item.dart';
import 'package:prison_foodie_admin/features/food_item/add_edit_food_item.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';

class FoodItemScreen extends StatefulWidget {
  const FoodItemScreen({super.key});

  @override
  State<FoodItemScreen> createState() => _FoodItemScreenState();
}

class _FoodItemScreenState extends State<FoodItemScreen> {
  final List<DummyFoodItem> foodItemList = List.from(deliveryDetail);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'FOOD Item Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomButton(
                inverse: true,
                label: 'Add Category',
                iconData: Icons.add,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddEditFoodItem(),
                  );
                },
              )
            ],
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
                return const Color(
                    0xffFCE4EC); // Default row color (light grey)
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
        'Item Name',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Item Price',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Item Image',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Item Category',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
    ];
  }

  List<DataRow> _createRows() {
    return foodItemList.map((e) {
      return DataRow(cells: [
        DataCell(
          Text(e.itemName),
        ),
        DataCell(
          Text(e.itemPrice.toString()),
        ),
        DataCell(
          Text(e.itemImageUrl),
        ),
        DataCell(
          Text(e.category),
        ),
      ]);
    }).toList();
  }
}
