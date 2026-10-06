import 'package:flutter/material.dart';

import 'package:aqualoops_app/data/app_data.dart';
import 'package:aqualoops_app/utils/app_colors.dart';

import 'package:aqualoops_app/screens/auth/login_screen.dart';
import 'package:aqualoops_app/screens/customer/address_screen.dart';
import 'package:aqualoops_app/screens/customer/notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    loggedInUser = null;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  // One option row in the profile list.
  Widget profileOption(
    IconData icon,
    String title,
    bool danger,
    VoidCallback? onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: danger ? AppColors.danger : AppColors.primary,
        ),
        title: Text(
          title,
          style: TextStyle(color: danger ? AppColors.danger : AppColors.black),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = loggedInUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? 'Guest User',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? 'user@example.com',
                      style: const TextStyle(color: AppColors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          profileOption(
            Icons.location_on_outlined,
            'Delivery Address',
            false,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddressScreen()),
              );
            },
          ),
          profileOption(Icons.notifications_none, 'Notifications', false, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          }),
          profileOption(Icons.help_outline, 'Help & Support', false, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Call us: +91 98765 43210')),
            );
          }),
          profileOption(Icons.logout, 'Log Out', true, () => logout(context)),
        ],
      ),
    );
  }
}
