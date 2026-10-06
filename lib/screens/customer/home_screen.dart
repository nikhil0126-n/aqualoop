import 'package:flutter/material.dart';

import 'package:aqualoops_app/data/app_data.dart';
import 'package:aqualoops_app/models/product.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/widgets/product_card.dart';
import 'package:aqualoops_app/widgets/category_card.dart';

import 'package:aqualoops_app/screens/customer/product_screen.dart';
import 'package:aqualoops_app/screens/customer/cart_screen.dart';
import 'package:aqualoops_app/screens/customer/my_orders_screen.dart';
import 'package:aqualoops_app/screens/customer/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeContent(),
    ProductScreen(),
    CartScreen(),
    MyOrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_outlined),
            activeIcon: Icon(Icons.water_drop),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// =====================================================
// HOME CONTENT
// =====================================================

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = [];
    for (Product product in allProducts) {
      if (product.name.toLowerCase().contains(searchText.toLowerCase())) {
        filteredProducts.add(product);
      }
    }

    // The clear button only shows when something is typed.
    Widget? clearSearchButton;
    if (searchText.isNotEmpty) {
      clearSearchButton = IconButton(
        onPressed: () {
          searchController.clear();
          setState(() {
            searchText = '';
          });
        },
        icon: const Icon(Icons.clear),
      );
    }

    // Empty state or the horizontal product list.
    Widget productsSection;
    if (filteredProducts.isEmpty) {
      productsSection = const Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Text(
            'No products found',
            style: TextStyle(color: AppColors.grey),
          ),
        ),
      );
    } else {
      productsSection = SizedBox(
        height: 265,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 14),
              child: ProductCard(product: filteredProducts[index]),
            );
          },
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================
            // HEADER
            // =====================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Aqua',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                        const Text(
                          'Loop',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Pure Water Delivery',
                      style: TextStyle(fontSize: 11, color: AppColors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Notification
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none),
                    ),
                    // Cart
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            // =====================================
            // GREETING
            // =====================================
            const Text(
              'Hello, User 👋',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'What would you like today?',
              style: TextStyle(fontSize: 14, color: AppColors.grey),
            ),
            const SizedBox(height: 18),
            // =====================================
            // SEARCH
            // =====================================
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for water...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                suffixIcon: clearSearchButton,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            // =====================================
            // CATEGORIES
            // =====================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductScreen(),
                      ),
                    );
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 105,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryCard(
                      title: '20L Water',
                      icon: Icons.water_drop,
                      onTap: () {},
                    ),
                    CategoryCard(
                      title: '1L Water',
                      icon: Icons.local_drink,
                      onTap: () {},
                    ),
                    CategoryCard(
                      title: '500ml',
                      icon: Icons.water,
                      onTap: () {},
                    ),
                    CategoryCard(
                      title: 'Premium',
                      icon: Icons.auto_awesome,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            // =====================================
            // PROMOTIONAL BANNER
            // =====================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pure Water,\nDelivered Fast!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Get fresh water at\nyour doorstep.',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.secondary,
                          ),
                          child: const Text('Shop Now'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.water_drop, color: Colors.white, size: 90),
                ],
              ),
            ),
            const SizedBox(height: 28),
            // =====================================
            // POPULAR PRODUCTS
            // =====================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductScreen(),
                      ),
                    );
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            productsSection,
            const SizedBox(height: 25),
            // =====================================
            // WHY AQUA LOOP
            // =====================================
            const Text(
              'Why AquaLoop?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                benefitCard(Icons.verified, 'Pure Water'),
                benefitCard(Icons.local_shipping, 'Fast Delivery'),
                benefitCard(Icons.support_agent, '24/7 Support'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget benefitCard(IconData icon, String title) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
