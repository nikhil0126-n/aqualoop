import 'package:flutter/material.dart';

import 'package:aqualoops_app/data/app_data.dart';
import 'package:aqualoops_app/models/user.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/widgets/custom_button.dart';
import 'package:aqualoops_app/widgets/custom_textfield.dart';

import 'package:aqualoops_app/screens/auth/register_screen.dart';
import 'package:aqualoops_app/screens/auth/forgot_password_screen.dart';
import 'package:aqualoops_app/screens/customer/home_screen.dart';
import 'package:aqualoops_app/screens/admin/admin_login_screen.dart';
import 'package:aqualoops_app/screens/supplier/supplier_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    // No credentials are required: tapping LOGIN goes straight to the
    // customer side. Whatever was typed (if anything) is kept as a label.
    String email = emailController.text.trim();
    if (email.isEmpty) email = 'user@aqualoop.com';

    loggedInUser = User(
      id: 1,
      name: 'User',
      email: email,
      phone: '9876543210',
      role: 'customer',
      address: '',
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Login to continue using AquaLoop',
              style: TextStyle(color: AppColors.grey),
            ),
            const SizedBox(height: 35),
            CustomTextField(
              controller: emailController,
              label: 'Email / Mobile',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              label: 'Password',
              prefixIcon: Icons.lock_outline,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  );
                },
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 15),
            CustomButton(
              label: 'LOGIN',
              isLoading: isLoading,
              onPressed: login,
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('Create Account'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Staff Login',
                style: TextStyle(color: AppColors.grey),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'ADMIN',
                    icon: Icons.admin_panel_settings_outlined,
                    isOutlined: true,
                    color: AppColors.adminPrimary,
                    height: 46,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminLoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    label: 'SUPPLIER',
                    icon: Icons.local_shipping_outlined,
                    isOutlined: true,
                    color: AppColors.supplierPrimary,
                    height: 46,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SupplierLogin(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
