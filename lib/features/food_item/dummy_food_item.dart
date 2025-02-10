import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';

class DummyFoodItem {
  final String itemName;
  final int itemPrice;
  final String itemImageUrl;
  final String category;
  final Widget action;

  DummyFoodItem({
    required this.action,
    required this.itemName,
    required this.itemPrice,
    required this.itemImageUrl,
    required this.category,
  });
}

List<DummyFoodItem> deliveryDetail = [
  DummyFoodItem(
      itemName: 'Chicken Biriyani',
      itemPrice: 120,
      itemImageUrl: '',
      category: 'Biriyani',
      action: _actionButtons()),
  DummyFoodItem(
      itemName: 'Mutton Biriyani',
      itemPrice: 180,
      itemImageUrl: '',
      category: 'Biriyani',
      action: _actionButtons()),
  DummyFoodItem(
      itemName: 'Veg Pulao',
      itemPrice: 100,
      itemImageUrl: '',
      category: 'Rice',
      action: _actionButtons()),
  DummyFoodItem(
      itemName: 'Butter Chicken',
      itemPrice: 250,
      itemImageUrl: '',
      category: 'Curry',
      action: _actionButtons()),
  DummyFoodItem(
      itemName: 'Paneer Tikka',
      itemPrice: 200,
      itemImageUrl: '',
      category: 'Starter',
      action: _actionButtons()),
  DummyFoodItem(
      itemName: 'Tandoori Roti',
      itemPrice: 30,
      itemImageUrl: '',
      category: 'Bread',
      action: _actionButtons()),
  DummyFoodItem(
      itemName: 'Malai Kofta',
      itemPrice: 220,
      itemImageUrl: '',
      category: 'Curry',
      action: _actionButtons()),
  DummyFoodItem(
      itemName: 'Fish Fry',
      itemPrice: 270,
      itemImageUrl: '',
      category: 'Seafood',
      action: _actionButtons()),
  DummyFoodItem(
      itemName: 'Prawns Masala',
      itemPrice: 300,
      itemImageUrl: '',
      category: 'Seafood',
      action: _actionButtons()),
  DummyFoodItem(
      itemName: 'Gulab Jamun',
      itemPrice: 50,
      itemImageUrl: '',
      category: 'Dessert',
      action: _actionButtons()),
];

Widget _actionButtons() {
  return Row(
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
          "Delete",
          style: TextStyle(color: onprimaryColor),
        ),
      ),
      const SizedBox(width: 8),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          "Edit",
          style: TextStyle(color: onprimaryColor),
        ),
      ),
      const SizedBox(width: 8),
      TextButton(
        onPressed: () {
          // Handle View Action
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue, // Text color
        ),
        child: const Text("View"),
      ),
    ],
  );
}
