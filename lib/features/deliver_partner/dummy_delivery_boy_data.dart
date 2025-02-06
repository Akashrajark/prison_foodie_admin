import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/theme/app_theme.dart';

class DummyDeliveryBoyData {
  final int id;
  final String name;
  final String email;
  final String status;
  final Widget action;

  DummyDeliveryBoyData({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.action,
  });
}

List<DummyDeliveryBoyData> deliveryDetail = [
  DummyDeliveryBoyData(
    id: 1,
    name: 'Ovy',
    email: 'ovy@gmail.com',
    status: 'Approved',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 2,
    name: 'John',
    email: 'john@gmail.com',
    status: 'Pending',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 3,
    name: 'Mike',
    email: 'mike@gmail.com',
    status: 'Approved',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 4,
    name: 'Sarah',
    email: 'sarah@gmail.com',
    status: 'Rejected',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 5,
    name: 'Alex',
    email: 'alex@gmail.com',
    status: 'Approved',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 6,
    name: 'Emma',
    email: 'emma@gmail.com',
    status: 'Pending',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 7,
    name: 'David',
    email: 'david@gmail.com',
    status: 'Approved',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 8,
    name: 'Lisa',
    email: 'lisa@gmail.com',
    status: 'Rejected',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 9,
    name: 'Tom',
    email: 'tom@gmail.com',
    status: 'Approved',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 10,
    name: 'Amy',
    email: 'amy@gmail.com',
    status: 'Pending',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 1,
    name: 'Ovy',
    email: 'ovy@gmail.com',
    status: 'Approved',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 2,
    name: 'John',
    email: 'john@gmail.com',
    status: 'Pending',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 3,
    name: 'Mike',
    email: 'mike@gmail.com',
    status: 'Approved',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 4,
    name: 'Sarah',
    email: 'sarah@gmail.com',
    status: 'Rejected',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 5,
    name: 'Alex',
    email: 'alex@gmail.com',
    status: 'Approved',
    action: _actionButtons(),
  ),
  DummyDeliveryBoyData(
    id: 6,
    name: 'Emma',
    email: 'emma@gmail.com',
    status: 'Pending',
    action: _actionButtons(),
  ),
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
