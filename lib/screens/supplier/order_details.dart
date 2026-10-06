import 'package:flutter/material.dart';

import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/widgets/custom_button.dart';

class OrderDetails extends StatelessWidget {
  final String orderId;
  final String customer;
  final double amount;
  final String status;

  const OrderDetails({
    super.key,
    this.orderId = '#AQ1001',
    this.customer = 'Priya Sharma',
    this.amount = 300,
    this.status = 'Pending',
  });

  final List<Map<String, dynamic>> _items = const [
    {'name': '20L Mineral Water', 'qty': 2, 'price': 120.0},
    {'name': '1L Water Bottle', 'qty': 3, 'price': 20.0},
  ];

  @override
  Widget build(BuildContext context) {
    final int currentStep = currentStepIndex();

    // Every row of the order items is built first.
    List<Widget> itemChildren = [];
    for (int i = 0; i < _items.length; i++) {
      Map<String, dynamic> item = _items[i];
      itemChildren.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.supplierLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.water_drop_outlined,
                  color: AppColors.supplierPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item['name']}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'x ${item['qty']}',
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '₹${(item['price'] * item['qty']).toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.supplierDark,
                ),
              ),
            ],
          ),
        ),
      );
    }
    itemChildren.add(const Divider(height: 22));
    itemChildren.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            '₹${amount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.supplierDark,
            ),
          ),
        ],
      ),
    );

    // The button at the bottom depends on the status.
    Widget actionButton;
    if (status == 'Pending') {
      actionButton = CustomButton(
        label: 'ACCEPT ORDER',
        onPressed: () {
          finish(context, 'Order $orderId accepted');
        },
      );
    } else {
      actionButton = CustomButton(
        label: 'MARK AS DELIVERED',
        onPressed: () {
          finish(context, 'Order $orderId marked as delivered');
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================
            // ORDER HEADER
            // =====================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
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
                        orderId,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      statusChip(status),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.schedule, size: 15, color: AppColors.grey),
                      SizedBox(width: 6),
                      Text(
                        '28 Sep 2026, 10:30 AM',
                        style: TextStyle(color: AppColors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                  const Divider(height: 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order Amount',
                        style: TextStyle(color: AppColors.grey),
                      ),
                      Text(
                        '₹${amount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.supplierDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // =====================================
            // CUSTOMER
            // =====================================
            Container(
              width: double.infinity,
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.supplierLight,
                    child: Icon(
                      Icons.person,
                      color: AppColors.supplierPrimary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.phone, size: 15, color: AppColors.grey),
                            SizedBox(width: 6),
                            Text(
                              '+91 98765 43210',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: AppColors.supplierPrimary,
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '14th Main, Indiranagar, Bengaluru 560038',
                                style: TextStyle(fontSize: 13, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.call, color: AppColors.success),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // =====================================
            // ITEMS
            // =====================================
            const Text(
              'Order Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
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
                children: itemChildren,
              ),
            ),
            const SizedBox(height: 16),
            // =====================================
            // DELIVERY INSTRUCTIONS
            // =====================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.supplierLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.supplierDark),
                      SizedBox(width: 8),
                      Text(
                        'Delivery Instructions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please call before arriving. If no one answers, leave the cans beside the main door and send a message.',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // =====================================
            // MAP PLACEHOLDER
            // =====================================
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.supplierLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.supplierPrimary.withValues(alpha: 0.25),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 46,
                    color: AppColors.supplierPrimary,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Map view',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // =====================================
            // STATUS TIMELINE
            // =====================================
            const Text(
              'Order Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
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
                children: [
                  statusStep(
                    'Placed',
                    'Order received from the customer',
                    currentStep > 0,
                    currentStep == 0,
                  ),
                  statusStep(
                    'Accepted',
                    'Supplier accepted the order',
                    currentStep > 1,
                    currentStep == 1,
                  ),
                  statusStep(
                    'Out for Delivery',
                    'Order is on the way to the customer',
                    currentStep > 2,
                    currentStep == 2,
                  ),
                  statusStep(
                    'Delivered',
                    'Order handed over to the customer',
                    currentStep > 3,
                    currentStep == 3,
                    true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // =====================================
            // ACTIONS
            // =====================================
            actionButton,
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  int currentStepIndex() {
    if (status == 'Accepted') {
      return 1;
    }
    if (status == 'Out for Delivery') {
      return 2;
    }
    if (status == 'Delivered') {
      return 4;
    }
    return 0;
  }

  void finish(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    Navigator.pop(context);
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
          fontSize: 11.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget statusStep(
    String title,
    String subtitle,
    bool isCompleted,
    bool isActive, [
    bool isLast = false,
  ]) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppColors.supplierPrimary
                    : isActive
                    ? Colors.white
                    : Colors.grey.shade200,
                border: isActive
                    ? Border.all(color: AppColors.supplierPrimary, width: 2)
                    : null,
              ),
              child: Icon(
                isCompleted
                    ? Icons.check
                    : isActive
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: 20,
                color: isCompleted ? Colors.white : AppColors.supplierPrimary,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 46,
                color: isCompleted
                    ? AppColors.supplierPrimary
                    : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCompleted || isActive
                        ? Colors.black
                        : AppColors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.grey, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
