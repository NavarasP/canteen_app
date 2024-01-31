import 'package:flutter/material.dart';
import 'package:canteen_app/services/models.dart';
import 'package:canteen_app/services/api_service.dart';
import 'package:canteen_app/services/local_service.dart';

class ItemScreen_Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Today\'s Special'),
          const SizedBox(height: 20),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return FutureBuilder<List<CanteenItem>>(
      future: CanteenService().getFoodList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No items available.');
        } else {
          List<CanteenItem> items = snapshot.data!;

          return Column(
            children: [
              for (CanteenItem item in items) _buildListItem(context, item),
            ],
          );
        }
      },
    );
  }

  Widget _buildListItem(BuildContext context, CanteenItem item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Price: ${item.price}'),
          Text('Quantity available: ${item.quantity}'),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {
          // Add the item to the cart and show the popup
          _addToCart(item, context);
        },
        child: Text('Add to Cart'),
      ),
    );
  }

  void _addToCart(CanteenItem item, BuildContext context) async {
    // Fetch existing cart items
    List<CartItem> cartItems = await CartService.loadCartItems();

    // Check if the item is already in the cart
    int index =
        cartItems.indexWhere((cartItem) => cartItem.itemName == item.name);

    if (index != -1) {
      // If the item is already in the cart, update the quantity
      cartItems[index].quantity++;
    } else {
      // If the item is not in the cart, add it with quantity 1
      cartItems.add(CartItem(
        itemName: item.name,
        itemPrice: item.price,
        quantity: 1,
      ));
    }

    // Save the updated cart items
    await CartService.saveCartItems(cartItems);

    // Show a popup indicating that the item has been added to the cart
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Item Added'),
          content: Text('${item.name} has been added to the cart.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
