import 'package:flutter/material.dart';

import 'package:aqualoops_app/data/app_data.dart';
import 'package:aqualoops_app/models/order.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/screens/customer/track_order_screen.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                'No orders yet',
                style: TextStyle(color: AppColors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: orders.length,
              itemBuilder: (context, index) =>
                  orderCard(context, orders[index]),
            ),
    );
  }

  // One card for one order inside the list.
  Widget orderCard(BuildContext context, Order order) {
    void openTracking(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TrackOrderScreen(orderId: order.id.replaceFirst('#', '')),
        ),
      );
    }

    String itemText = '';
    for (int i = 0; i < order.items.length; i++) {
      String name = order.items[i].product.name;
      int qty = order.items[i].quantity;
      if (i == 0) {
        itemText = '$name x $qty';
      } else {
        itemText = '$itemText, $name x $qty';
      }
    }
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => openTracking(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.id,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Placed',
                        style: TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: AppColors.secondary,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                dateLabel(order.date),
                style: const TextStyle(color: AppColors.grey),
              ),
              const Divider(height: 24),
              Text(itemText),
              const SizedBox(height: 8),
              Text(
                order.paymentMethod,
                style: const TextStyle(color: AppColors.grey),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${order.total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Tap to track this order',
                style: TextStyle(color: AppColors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String dateLabel(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
