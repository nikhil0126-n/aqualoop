import 'dart:async';

import 'package:flutter/material.dart';

import 'package:aqualoops_app/data/app_data.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/screens/auth/login_screen.dart';
import 'package:aqualoops_app/screens/customer/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      // Already signed in? Skip the login screen.
      if (loggedInUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFE8FFFF)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.water_drop, size: 90, color: AppColors.primary),
            const SizedBox(height: 20),
            const Text(
              'AquaLoop',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pure Water Delivery',
              style: TextStyle(fontSize: 15, color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
