import 'package:flutter/material.dart';

import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/widgets/custom_button.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  bool isStarted = false;

  final List<Map<String, dynamic>> stops = const [
    {
      'number': 1,
      'name': 'Priya Sharma',
      'area': 'Indiranagar',
      'distance': '0.8 km',
      'isDone': true,
    },
    {
      'number': 2,
      'name': 'Amit Verma',
      'area': 'Domlur',
      'distance': '2.4 km',
      'isCurrent': true,
    },
    {
      'number': 3,
      'name': 'Sneha Reddy',
      'area': 'HAL 2nd Stage',
      'distance': '3.2 km',
    },
    {
      'number': 4,
      'name': 'Karan Mehta',
      'area': 'Old Airport Road',
      'distance': '4.1 km',
    },
    {
      'number': 5,
      'name': 'Ananya Iyer',
      'area': 'Koramangala',
      'distance': '5.6 km',
    },
    {
      'number': 6,
      'name': 'Rohit Nair',
      'area': 'HSR Layout',
      'distance': '7.2 km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Build every child of the column with plain code (no spreads).
    List<Widget> columnChildren = [];
    columnChildren.add(buildHeroCard());
    columnChildren.add(const SizedBox(height: 20));

    // Map placeholder
    columnChildren.add(
      Container(
        width: double.infinity,
        height: 210,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.supplierPrimary.withValues(alpha: 0.3),
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.navigation, size: 52, color: AppColors.supplierDark),
            SizedBox(height: 10),
            Text(
              'Route to customer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.supplierDark,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Turn left in 400 m onto CMH Road',
              style: TextStyle(color: AppColors.grey, fontSize: 12.5),
            ),
          ],
        ),
      ),
    );

    columnChildren.add(const SizedBox(height: 20));
    columnChildren.add(
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Route Stops',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '6 stops',
            style: TextStyle(color: AppColors.grey, fontSize: 13),
          ),
        ],
      ),
    );
    columnChildren.add(const SizedBox(height: 12));
    for (int i = 0; i < stops.length; i++) {
      columnChildren.add(buildStopCard(stops[i]));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deliveries'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnChildren,
        ),
      ),
    );
  }

  Widget buildHeroCard() {
    return Container(
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
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.supplierPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_shipping,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Delivery',
                      style: TextStyle(color: AppColors.grey, fontSize: 12.5),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Stop 2 of 8',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.supplierPrimary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isStarted ? 'In Progress' : 'Not Started',
                  style: const TextStyle(
                    color: AppColors.supplierDark,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: infoTile('Customer', 'Amit Verma')),
              Expanded(child: infoTile('ETA', '12 min')),
              Expanded(child: infoTile('Distance', '2.4 km')),
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(
            label: isStarted ? 'COMPLETE STOP' : 'START DELIVERY',
            icon: isStarted ? Icons.check_circle_outline : Icons.play_arrow,
            onPressed: () {
              setState(() {
                isStarted = !isStarted;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isStarted
                        ? 'Delivery started for Stop 2'
                        : 'Stop 2 marked as completed',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildStopCard(Map<String, dynamic> stop) {
    // Texts and (optionally) the action buttons of the stop.
    List<Widget> cardChildren = [];
    cardChildren.add(
      Text(
        '${stop['name']}',
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
    cardChildren.add(const SizedBox(height: 4));
    cardChildren.add(
      Text(
        '${stop['area']} • ${stop['distance']}',
        style: const TextStyle(color: AppColors.grey, fontSize: 12.5),
      ),
    );
    if (stop['isCurrent'] == true) {
      cardChildren.add(const SizedBox(height: 8));
      cardChildren.add(
        Row(
          children: [
            actionButton(Icons.call, () {}),
            actionButton(Icons.message_outlined, () {}),
            actionButton(Icons.navigation_outlined, () {}),
          ],
        ),
      );
    }

    // Badge, texts and the trailing icon of the row.
    List<Widget> rowChildren = [];
    rowChildren.add(stopBadge(stop));
    rowChildren.add(const SizedBox(width: 12));
    rowChildren.add(
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cardChildren,
        ),
      ),
    );
    if (stop['isDone'] != true && stop['isCurrent'] != true) {
      rowChildren.add(
        const Icon(Icons.schedule, color: AppColors.grey, size: 22),
      );
    } else if (stop['isCurrent'] == true) {
      rowChildren.add(
        const Icon(
          Icons.chevron_right,
          color: AppColors.supplierPrimary,
          size: 24,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: stop['isCurrent'] == true
            ? Border.all(color: AppColors.supplierPrimary, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(children: rowChildren),
    );
  }

  Widget stopBadge(Map<String, dynamic> stop) {
    if (stop['isDone'] == true) {
      return const Icon(Icons.check_circle, color: AppColors.success, size: 34);
    }
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: stop['isCurrent'] == true
            ? AppColors.supplierPrimary
            : AppColors.supplierLight,
      ),
      child: Text(
        '${stop['number']}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: stop['isCurrent'] == true
              ? Colors.white
              : AppColors.supplierDark,
        ),
      ),
    );
  }

  Widget actionButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: AppColors.supplierDark),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
    );
  }

  Widget infoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.grey, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
