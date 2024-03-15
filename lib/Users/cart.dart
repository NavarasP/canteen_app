import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:canteen_app/Services/local_service.dart';
import 'package:canteen_app/Services/api_models/users_models.dart';
import 'package:canteen_app/Services/api/canteen_service_user.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

  Future<void> checkout(String selectedDateTime) async {
    // Proceed with the checkout using the selectedDateTime
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Order'),
          content: const Text('Are you sure you want to place this order?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Dismiss dialog with false
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Dismiss dialog with true
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        // Prepare the list of products
        List<Map<String, dynamic>> products = cartItems.map((item) {
          return {
            'id': item.itemId,
            'quantity': item.quantity,
          };
        }).toList();

        // Call the API to place the order
        await CanteenServiceUser().placeOrder(products, selectedDateTime);

        // Clear the cart after a successful order
        await CartService.clearCart();
        setState(() {
          cartItems.clear();
        });

        // Show a success dialog
        showDialog(
          // ignore: use_build_context_synchronously
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
        debugPrint('Error placing order: $e');
        // Show an error dialog
        showDialog(
          // ignore: use_build_context_synchronously
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
                showDateTimePicker(context);
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }

void showDateTimePicker(BuildContext context) async {
  DateTime? selectedDateTime = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 7)), 
  );

  if (selectedDateTime != null) {
    TimeOfDay? selectedTime = await showTimePicker(
      // ignore: use_build_context_synchronously
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Combine the selected date and time into a single DateTime object
      selectedDateTime = DateTime(
        selectedDateTime.year,
        selectedDateTime.month,
        selectedDateTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      // Format the selectedDateTime into the desired format
      String formattedDateTime = DateFormat("MMM dd yyyy HH:mm:ss").format(selectedDateTime);

      // Call checkout function with formatted delivery date and time
      checkout(formattedDateTime);
    }
  }
}

}
