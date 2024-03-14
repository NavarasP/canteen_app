import 'package:flutter/material.dart';
import 'package:canteen_app/Services/local_service.dart';
import 'package:canteen_app/Services/Models/users_models.dart';
import 'package:canteen_app/Services/api/canteen_service_user.dart';

class ItemScreenUsers extends StatefulWidget {
  const ItemScreenUsers({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ItemScreenUsersState createState() => _ItemScreenUsersState();
}

class _ItemScreenUsersState extends State<ItemScreenUsers> {
  List<CanteenItemStudent> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      List<CanteenItemStudent> loadedItems =
          await CanteenServiceUser().getFoodListUser();
      setState(() {
        items = loadedItems;
      });
    } catch (e) {
      debugPrint('Error loading items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListItem(),
    );
  }

  Widget _buildListItem() {
    List<CanteenItemStudent> approvedItems =
        items.where((item) => item.quantity > 0).toList();

    return ListView.builder(
      itemCount: approvedItems.length,
      itemBuilder: (context, index) {
        CanteenItemStudent item = approvedItems[index];
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
            onPressed:  () {
              _addToCart(item, context);
            },
            child: const Text('Add to Cart'),
          ),
        );
      },
    );
  }

  void _addToCart(CanteenItemStudent item, BuildContext context) async {
    List<CartItem> cartItems = await CartService.loadCartItems();
    int index = cartItems.indexWhere((cartItem) => cartItem.itemId == item.id);

    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem(
        itemId: item.id,
        itemName: item.name,
        itemPrice: item.price,
        quantity: 1,
      ));
    }

    // Save the updated cart items
    await CartService.updateCartItems(cartItems);

    // Show a popup indicating that the item has been added to the cart
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Item Added'),
          content: Text('${item.name} has been added to the cart.'),
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
