import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/common_widget/custom_drawer.dart';
import 'package:prison_foodie_admin/features/Order_details/order_details_screen.dart';
import 'package:prison_foodie_admin/features/category/category_screen.dart';
import 'package:prison_foodie_admin/features/dashboard/dashboard.dart';
import 'package:prison_foodie_admin/features/deliver_partner/deliver_partner_screen.dart';
import 'package:prison_foodie_admin/features/food_item/food_item_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDrawer(
        tabController: _tabController,
      ),
      body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Dashboard(),
            DeliverPartnerScreen(),
            OrderDetailsScreen(),
            // PaymentDetailsScreen(),
            CategoryScreen(),
            FoodItemScreen()
          ]),
    );
  }
}
