import 'package:flutter/material.dart';
import 'package:canteen_app/Models/users_models.dart';
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

  void updateQuantity(CartItem cartItem, int change) {
    setState(() {
      cartItem.quantity = (cartItem.quantity + change).clamp(0, 99);
      if (cartItem.quantity == 0) {
        // Remove the item from the cart if its quantity is zero
        cartItems.remove(cartItem);
      }
      CartService.updateCartItems(cartItems);
    });
  }

  Future<void> checkout() async {
    // Implement your checkout logic here
    // Call the order API with cartItems
    try {
      // Placeholder API call
      // Replace this with your actual order API call
      // await OrderService.placeOrder(cartItems);

      // Clear the cart after a successful order
      await CartService.clearCart();
      setState(() {
        cartItems.clear();
      });

      // Show a confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Order Placed'),
            content: const Text('Your order has been placed successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle errors
      print('Error placing order: $e');
      // Show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to place the order. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount =
        cartItems.fold(0, (sum, item) => sum + item.itemPrice * item.quantity);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Price: \$${cartItem.itemPrice}'),
                      const SizedBox(width: 10),
                      Text('Count: ${cartItem.quantity}'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          updateQuantity(cartItem, -1);
                        },
                      ),
                      Text('${cartItem.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          updateQuantity(cartItem, 1);
                        },
                      ),
                    ],
                  ),
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
                checkout(); // Call the checkout function
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
