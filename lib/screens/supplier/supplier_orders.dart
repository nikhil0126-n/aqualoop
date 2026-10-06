import 'package:flutter/material.dart';

import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/screens/supplier/order_details.dart';

class SupplierOrders extends StatefulWidget {
  const SupplierOrders({super.key});

  @override
  State<SupplierOrders> createState() => _SupplierOrdersState();
}

class _SupplierOrdersState extends State<SupplierOrders> {
  final List<String> filters = const ['All', 'Pending', 'Delivered'];

  String selectedFilter = 'All';

  final List<Map<String, dynamic>> orders = const [
    {
      'orderId': '#AQ1001',
      'customer': 'Priya Sharma',
      'items': '20L Mineral Water x 2, 1L Water Bottle x 3',
      'address': '14th Main, Indiranagar, Bengaluru',
      'amount': 300.0,
      'status': 'Pending',
    },
    {
      'orderId': '#AQ1002',
      'customer': 'Amit Verma',
      'items': '20L Mineral Water x 1, 1L Water Bottle x 4',
      'address': 'CMH Road, Domlur, Bengaluru',
      'amount': 190.0,
      'status': 'Out for Delivery',
    },
    {
      'orderId': '#AQ1003',
      'customer': 'Sneha Reddy',
      'items': '20L Premium Water x 3',
      'address': 'HAL 2nd Stage, Bengaluru',
      'amount': 360.0,
      'status': 'Delivered',
    },
    {
      'orderId': '#AQ1004',
      'customer': 'Karan Mehta',
      'items': '500ml Bottle x 6, 1L Water Bottle x 2',
      'address': 'Old Airport Road, Bengaluru',
      'amount': 100.0,
      'status': 'Delivered',
    },
    {
      'orderId': '#AQ1005',
      'customer': 'Ananya Iyer',
      'items': '20L Mineral Water x 2, 1L Water Bottle x 6',
      'address': 'Koramangala 5th Block, Bengaluru',
      'amount': 300.0,
      'status': 'Pending',
    },
    {
      'orderId': '#AQ1006',
      'customer': 'Rohit Nair',
      'items': '20L Premium Water x 1',
      'address': 'Sector 1, HSR Layout, Bengaluru',
      'amount': 120.0,
      'status': 'Delivered',
    },
    {
      'orderId': '#AQ1007',
      'customer': 'Meera Joshi',
      'items': '20L Mineral Water x 4',
      'address': 'JP Nagar 6th Phase, Bengaluru',
      'amount': 480.0,
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Only the orders of the selected filter are shown.
    List<Map<String, dynamic>> visibleOrders;
    if (selectedFilter == 'All') {
      visibleOrders = orders;
    } else {
      List<Map<String, dynamic>> result = [];
      for (int i = 0; i < orders.length; i++) {
        if (orders[i]['status'] == selectedFilter) {
          result.add(orders[i]);
        }
      }
      visibleOrders = result;
    }

    // The list of orders (or the empty message) is chosen first.
    Widget body;
    if (visibleOrders.isEmpty) {
      body = emptyOrders();
    } else {
      body = ListView.builder(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
        itemCount: visibleOrders.length,
        itemBuilder: (context, index) => orderCard(visibleOrders[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          buildFilters(),
          Expanded(child: body),
        ],
      ),
    );
  }

  Widget buildFilters() {
    // Every filter chip is built first.
    List<Widget> chips = [];
    for (int i = 0; i < filters.length; i++) {
      String filter = filters[i];
      final bool isSelected = selectedFilter == filter;
      chips.add(
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ChoiceChip(
            label: Text(filter),
            selected: isSelected,
            showCheckmark: false,
            selectedColor: AppColors.supplierPrimary,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.grey,
            ),
            onSelected: (_) {
              setState(() {
                selectedFilter = filter;
              });
            },
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 4),
      child: Row(children: chips),
    );
  }

  Widget orderCard(Map<String, dynamic> order) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetails(
              orderId: '${order['orderId']}',
              customer: '${order['customer']}',
              amount: order['amount'],
              status: '${order['status']}',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order['orderId']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                statusChip('${order['status']}'),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '${order['customer']}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              '${order['items']}',
              style: const TextStyle(color: AppColors.grey, fontSize: 13),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.grey,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${order['address']}',
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${order['amount'].toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.supplierDark,
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.supplierPrimary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.supplierPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget statusChip(String status) {
    Color color;
    if (status == 'Delivered') {
      color = AppColors.success;
    } else if (status == 'Out for Delivery') {
      color = AppColors.supplierPrimary;
    } else {
      color = const Color(0xFFF59E0B);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget emptyOrders() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 60, color: AppColors.grey),
          SizedBox(height: 14),
          Text(
            'No orders found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Orders matching this filter will appear here.',
            style: TextStyle(color: AppColors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
