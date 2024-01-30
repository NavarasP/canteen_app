import 'package:flutter/material.dart';
import 'package:canteen_app/models.dart';
import 'package:canteen_app/services/local_service.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    final List<CartItem> loadedCartItems = await CartService.loadCartItems();

    setState(() {
      cartItems = loadedCartItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(0, (sum, item) => sum + item.itemPrice * item.quantity);

    return Scaffold(
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          CartItem cartItem = cartItems[index];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(cartItem.itemName),
              subtitle: Row(
                children: [
                  Text('Price: \$${cartItem.itemPrice}'),
                  const SizedBox(width: 10),
                  Text('Count: ${cartItem.quantity}'),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: \$${totalAmount.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                // Implement your checkout logic here
                print('Checkout button pressed');
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
