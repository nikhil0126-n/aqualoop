import 'package:flutter/material.dart';

import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/widgets/custom_button.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  final List<Map<String, dynamic>> _week = const [
    {'day': 'Mon', 'amount': 520.0},
    {'day': 'Tue', 'amount': 460.0},
    {'day': 'Wed', 'amount': 480.0},
    {'day': 'Thu', 'amount': 540.0},
    {'day': 'Fri', 'amount': 420.0},
    {'day': 'Sat', 'amount': 340.0},
    {'day': 'Sun', 'amount': 360.0},
  ];

  final List<Map<String, dynamic>> _breakdown = const [
    {
      'icon': Icons.local_shipping,
      'title': 'Delivery Charges',
      'subtitle': '₹20 × 156 deliveries',
      'amount': 3120.0,
    },
    {
      'icon': Icons.card_giftcard,
      'title': 'Weekly Bonus',
      'subtitle': '5 day streak reward',
      'amount': 300.0,
    },
    {
      'icon': Icons.group_add,
      'title': 'Referral Bonus',
      'subtitle': 'Referred 2 new suppliers',
      'amount': 500.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeroCard(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: summaryCard('Today', '₹480', Icons.today_outlined),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: summaryCard(
                    'This Week',
                    '₹3,120',
                    Icons.date_range_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: summaryCard(
                    'Bonus',
                    '₹300',
                    Icons.card_giftcard_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            buildBarChart(),
            const SizedBox(height: 24),
            const Text(
              'Earnings Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            buildBreakdownCard(),
            const SizedBox(height: 24),
            CustomButton(
              label: 'WITHDRAW EARNINGS',
              icon: Icons.account_balance_wallet_outlined,
              onPressed: () {
                showWithdrawDialog(context);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.supplierDark, AppColors.supplierPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Earnings',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'This Week',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            '₹24,580',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Lifetime earnings from deliveries',
            style: TextStyle(color: Colors.white70, fontSize: 12.5),
          ),
        ],
      ),
    );
  }

  Widget buildBarChart() {
    // Highest amount of the week (used to scale the bars).
    double maxAmount = _week[0]['amount'];
    for (int i = 1; i < _week.length; i++) {
      if (_week[i]['amount'] > maxAmount) {
        maxAmount = _week[i]['amount'];
      }
    }

    // One column per day of the week.
    List<Widget> bars = [];
    for (int i = 0; i < _week.length; i++) {
      Map<String, dynamic> entry = _week[i];
      double barHeight = (entry['amount'] / maxAmount) * 115 + 12;
      bars.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '₹${entry['amount'].toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 9.5, color: AppColors.grey),
            ),
            const SizedBox(height: 6),
            Container(
              width: 26,
              height: barHeight,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.supplierPrimary, AppColors.supplierDark],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${entry['day']}',
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      );
    }

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Earnings',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹3,120',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.supplierDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Simple bar chart built with Row + Column + Container only.
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bars,
          ),
        ],
      ),
    );
  }

  Widget buildBreakdownCard() {
    // A divider between every row, then the row itself.
    List<Widget> rows = [];
    for (int i = 0; i < _breakdown.length; i++) {
      if (i > 0) {
        rows.add(const Divider(height: 26));
      }
      rows.add(breakdownRow(_breakdown[i]));
    }

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
        children: rows,
      ),
    );
  }

  Widget breakdownRow(Map<String, dynamic> item) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.supplierLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(item['icon'], color: AppColors.supplierPrimary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item['title']}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 3),
              Text(
                '${item['subtitle']}',
                style: const TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        Text(
          '₹${item['amount'].toStringAsFixed(0)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.supplierDark,
          ),
        ),
      ],
    );
  }

  Future<void> showWithdrawDialog(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Withdraw Earnings'),
        content: const Text(
          'Transfer your available balance to your registered bank account?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Withdrawal request submitted successfully'),
      ),
    );
  }

  Widget summaryCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
          Icon(icon, size: 20, color: AppColors.supplierPrimary),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.supplierDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: AppColors.grey, fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}
