import 'package:flutter/material.dart';

import 'package:aqualoops_app/data/app_data.dart';
import 'package:aqualoops_app/models/cart.dart';
import 'package:aqualoops_app/models/order.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/screens/customer/order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // The address is optional — an order can be placed without typing it.
  final addressController = TextEditingController();
  String paymentMethod = 'Cash on Delivery';
  bool placingOrder = false;

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  void submitOrder() {
    setState(() {
      placingOrder = true;
    });

    // Copy the cart items into order items.
    List<CartOrderItem> items = [];
    for (CartItem item in cartItems) {
      items.add(CartOrderItem(product: item.product, quantity: item.quantity));
    }

    placeOrder(
      items: items,
      total: getCartTotal() + 10,
      address: addressController.text.trim(),
      paymentMethod: paymentMethod,
    );
    clearCart();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Order placed successfully')));

    // Go to the success screen with the real order number.
    String orderId;
    if (orders.isEmpty) {
      orderId = '1025';
    } else {
      orderId = orders.first.id.replaceFirst('#', '');
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSuccessScreen(orderId: orderId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const deliveryCharge = 10.0;
    final total = getCartTotal() + deliveryCharge;

    // Show a spinner on the button while the order is being placed.
    Widget buttonChild;
    if (placingOrder) {
      buttonChild = const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    } else {
      buttonChild = const Text(
        'PLACE ORDER',
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Delivery address',
                prefixIcon: Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            paymentOption(Icons.money, 'Cash on Delivery'),
            paymentOption(Icons.credit_card, 'Online Payment'),
            const SizedBox(height: 25),
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            summaryRow('Subtotal', '₹${getCartTotal().toStringAsFixed(0)}'),
            summaryRow('Delivery', '₹${deliveryCharge.toStringAsFixed(0)}'),
            const Divider(),
            summaryRow('Total', '₹${total.toStringAsFixed(0)}', bold: true),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: placingOrder || cartItems.isEmpty
                    ? null
                    : submitOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: buttonChild,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentOption(IconData icon, String title) {
    bool selected = paymentMethod == title;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            paymentMethod = title;
          });
        },
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(width: 15),
              Expanded(child: Text(title)),
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? AppColors.primary : AppColors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget summaryRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: bold ? 18 : 15,
              fontWeight: bold ? FontWeight.bold : null,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 20 : 15,
              fontWeight: bold ? FontWeight.bold : null,
              color: bold ? AppColors.secondary : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
