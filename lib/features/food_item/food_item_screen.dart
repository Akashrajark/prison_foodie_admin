import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_admin/common_widget/custom_button.dart';
import 'package:prison_foodie_admin/common_widget/custom_search.dart';
import 'package:prison_foodie_admin/features/food_item/add_edit_food_item.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../common_widget/custom_text_with_label.dart';
import '../../util/check_login.dart';
import 'food_items_bloc/food_items_bloc.dart';

class FoodItemScreen extends StatefulWidget {
  const FoodItemScreen({super.key});

  @override
  State<FoodItemScreen> createState() => _FoodItemScreenState();
}

class _FoodItemScreenState extends State<FoodItemScreen> {
  final FoodItemsBloc _foodItemsBloc = FoodItemsBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map> _foodItems = [];

  @override
  void initState() {
    checkLogin(context);
    getFoodItems();
    super.initState();
  }

  void getFoodItems() {
    _foodItemsBloc.add(GetAllFoodItemsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _foodItemsBloc,
      child: BlocConsumer<FoodItemsBloc, FoodItemsState>(
        listener: (context, state) {
          if (state is FoodItemsFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getFoodItems();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is FoodItemsGetSuccessState) {
            _foodItems = state.foodItems;
            Logger().w(_foodItems);
            setState(() {});
          } else if (state is FoodItemsSuccessState) {
            getFoodItems();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Food Items',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: CustomSearch(
                        onSearch: (query) {
                          params['query'] = query;
                          getFoodItems();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      inverse: true,
                      label: 'Add Food',
                      iconData: Icons.add,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: _foodItemsBloc,
                            child: const AddEditFoodItem(),
                          ),
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                if (state is FoodItemsLoadingState) LinearProgressIndicator(),
                if (state is FoodItemsGetSuccessState && _foodItems.isEmpty)
                  Center(
                    child: Text("No Food found!"),
                  ),
                if (state is FoodItemsGetSuccessState && _foodItems.isNotEmpty)
                  Expanded(
                    child: DataTable2(
                      columnSpacing: 12,
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
                        _foodItems.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(
                              Text(_foodItems[index]['name']),
                            ),
                            DataCell(
                              Text(_foodItems[index]['price'].toString()),
                            ),
                            DataCell(
                              Text(_foodItems[index]['count'].toString()),
                            ),
                            DataCell(
                              Text(_foodItems[index]['category']?['name']),
                            ),
                            DataCell(
                              CustomButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => FoodItemDetailDialog(
                                      foodItemDetails: (_foodItems[index]),
                                    ),
                                  );
                                },
                                label: 'view',
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
        'Name',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Price',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Count',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      )),
      const DataColumn(
          label: Text(
        'Category',
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
}

class FoodItemDetailDialog extends StatelessWidget {
  final Map foodItemDetails;
  const FoodItemDetailDialog({
    super.key,
    required this.foodItemDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Food item detail',
      width: 500,
      content: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                fit: BoxFit.cover,
                foodItemDetails['image_url'],
                height: 200,
                width: 200,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                spacing: 10,
                children: [
                  TextWithLabel(
                    label: 'Food Item Name',
                    text: foodItemDetails['name'],
                  ),
                  TextWithLabel(
                    label: 'Item Price',
                    text: foodItemDetails['price'].toString(),
                  ),
                  TextWithLabel(
                    label: 'Available count',
                    text: foodItemDetails['count'].toString(),
                  ),
                  TextWithLabel(
                    label: 'Category Name',
                    text: foodItemDetails['category']['name'],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          TextWithLabel(
            label: 'Description',
            text: foodItemDetails['description'],
          ),
        ],
      ),
    );
  }
}
