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
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          updateQuantity(cartItem, -1);
                        },
                      ),
                      Text('${cartItem.quantity}'),
                      IconButton(
                        icon: Icon(Icons.add),
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
