import 'package:flutter/material.dart';

class DummyOrderDetails {
  final int orderId;
  final int deliveryBoyId;
  final String deliveryBoyName;
  final String userName;
  final int price;
  final String status;
  final Widget items;

  DummyOrderDetails({
    required this.orderId,
    required this.deliveryBoyId,
    required this.deliveryBoyName,
    required this.userName,
    required this.price,
    required this.status,
    required this.items,
  });
}

List<DummyOrderDetails> orderDetails = [
  DummyOrderDetails(
      orderId: 1,
      deliveryBoyId: 15,
      deliveryBoyName: 'Solaman',
      userName: 'Koran',
      price: 550,
      status: 'Pending',
      items: _item()),
  DummyOrderDetails(
      orderId: 2,
      deliveryBoyId: 20,
      deliveryBoyName: 'Rahul',
      userName: 'David',
      price: 700,
      status: 'Delivered',
      items: _item()),
  DummyOrderDetails(
      orderId: 3,
      deliveryBoyId: 25,
      deliveryBoyName: 'Amit',
      userName: 'John',
      price: 450,
      status: 'Pending',
      items: _item()),
  DummyOrderDetails(
      orderId: 4,
      deliveryBoyId: 30,
      deliveryBoyName: 'Vikas',
      userName: 'Michael',
      price: 620,
      status: 'Delivered',
      items: _item()),
  DummyOrderDetails(
      orderId: 5,
      deliveryBoyId: 35,
      deliveryBoyName: 'Raj',
      userName: 'Sarah',
      price: 800,
      status: 'Pending',
      items: _item()),
  DummyOrderDetails(
      orderId: 6,
      deliveryBoyId: 40,
      deliveryBoyName: 'Ankit',
      userName: 'Emma',
      price: 920,
      status: 'Delivered',
      items: _item()),
  DummyOrderDetails(
      orderId: 7,
      deliveryBoyId: 45,
      deliveryBoyName: 'Sunny',
      userName: 'Liam',
      price: 330,
      status: 'Pending',
      items: _item()),
  DummyOrderDetails(
      orderId: 8,
      deliveryBoyId: 50,
      deliveryBoyName: 'Ravi',
      userName: 'Olivia',
      price: 770,
      status: 'Delivered',
      items: _item()),
  DummyOrderDetails(
      orderId: 9,
      deliveryBoyId: 55,
      deliveryBoyName: 'Deepak',
      userName: 'Sophia',
      price: 540,
      status: 'Pending',
      items: _item()),
  DummyOrderDetails(
      orderId: 10,
      deliveryBoyId: 60,
      deliveryBoyName: 'Kunal',
      userName: 'James',
      price: 990,
      status: 'Delivered',
      items: _item()),
  DummyOrderDetails(
      orderId: 1,
      deliveryBoyId: 15,
      deliveryBoyName: 'Solaman',
      userName: 'Koran',
      price: 550,
      status: 'Pending',
      items: _item()),
  DummyOrderDetails(
      orderId: 2,
      deliveryBoyId: 20,
      deliveryBoyName: 'Rahul',
      userName: 'David',
      price: 700,
      status: 'Delivered',
      items: _item()),
  DummyOrderDetails(
      orderId: 3,
      deliveryBoyId: 25,
      deliveryBoyName: 'Amit',
      userName: 'John',
      price: 450,
      status: 'Pending',
      items: _item()),
  DummyOrderDetails(
      orderId: 4,
      deliveryBoyId: 30,
      deliveryBoyName: 'Vikas',
      userName: 'Michael',
      price: 620,
      status: 'Delivered',
      items: _item()),
  DummyOrderDetails(
      orderId: 5,
      deliveryBoyId: 35,
      deliveryBoyName: 'Raj',
      userName: 'Sarah',
      price: 800,
      status: 'Pending',
      items: _item()),
  DummyOrderDetails(
      orderId: 6,
      deliveryBoyId: 40,
      deliveryBoyName: 'Ankit',
      userName: 'Emma',
      price: 920,
      status: 'Delivered',
      items: _item()),
  DummyOrderDetails(
      orderId: 7,
      deliveryBoyId: 45,
      deliveryBoyName: 'Sunny',
      userName: 'Liam',
      price: 330,
      status: 'Pending',
      items: _item()),
];

Widget _item() {
  return TextButton(
    onPressed: () {
      // Handle View Action
    },
    style: TextButton.styleFrom(
      foregroundColor: Colors.blue, // Text color
    ),
    child: const Text("View"),
  );
}
