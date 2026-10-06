import 'package:flutter/material.dart';

import 'package:aqualoops_app/data/app_data.dart';
import 'package:aqualoops_app/models/cart.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/screens/customer/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    const double deliveryCharge = 10;
    final double grandTotal = getCartTotal() + deliveryCharge;

    // Show a friendly empty screen when there is nothing in the cart.
    Widget body;
    if (cartItems.isEmpty) {
      body = const EmptyCart();
    } else {
      body = Column(
        children: [
          // Cart products
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return cartItem(index);
              },
            ),
          ),

          // Bottom summary
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.15),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                priceRow('Subtotal', '₹${getCartTotal().toStringAsFixed(0)}'),
                const SizedBox(height: 8),
                priceRow('Delivery', '₹$deliveryCharge'),
                const Divider(height: 25),
                priceRow(
                  'Total',
                  '₹${grandTotal.toStringAsFixed(0)}',
                  bold: true,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'PROCEED TO CHECKOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: body,
    );
  }

  // One row in the cart list.
  Widget cartItem(int index) {
    CartItem item = cartItems[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.12), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          // Product image
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: const Color(0xFFEFFFFF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.water_drop,
              color: AppColors.primary,
              size: 45,
            ),
          ),

          const SizedBox(width: 12),

          // Product information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '₹${item.product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 8),

                // Quantity controls
                Row(
                  children: [
                    quantityButton(
                      icon: Icons.remove,
                      onTap: () {
                        setState(() {
                          decreaseQuantity(index);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    quantityButton(
                      icon: Icons.add,
                      onTap: () {
                        setState(() {
                          increaseQuantity(index);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delete
          IconButton(
            onPressed: () {
              setState(() {
                removeFromCart(index);
              });
            },
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget quantityButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFEFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }

  Widget priceRow(String title, String price, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: bold ? 18 : 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: bold ? 20 : 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: bold ? AppColors.secondary : Colors.black,
          ),
        ),
      ],
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 90,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          const Text(
            'Your Cart is Empty',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add some water products to continue.',
            style: TextStyle(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
