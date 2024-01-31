import 'package:flutter/material.dart';
import 'package:canteen_app/Models/users_models.dart';
import 'package:canteen_app/services/local_service.dart';
import 'package:canteen_app/services/api/canteen_service__student.dart';


class ItemScreen_Users extends StatefulWidget {
  @override
  _ItemScreen_UsersState createState() => _ItemScreen_UsersState();
}

class _ItemScreen_UsersState extends State<ItemScreen_Users> {
  List<CanteenItem_Student> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      List<CanteenItem_Student> loadedItems = await CanteenService_User().getFoodList_user();
      setState(() {
        items = loadedItems;
      });
    } catch (e) {
      // Handle errors
      print('Error loading items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inspector Item List'),
      ),
      body: _buildListItem(),
    );
  }

  Widget _buildListItem() {
    // Filter items to show only approved ones
    List<CanteenItem_Student> approvedItems = items.where((item) => item.isTodaysSpecial).toList();

    return ListView.builder(
      itemCount: approvedItems.length,
      itemBuilder: (context, index) {
        CanteenItem_Student item = approvedItems[index];
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
      },
    );
  }

  void _addToCart(CanteenItem_Student item, BuildContext context) async {
    List<CartItem> cartItems = await CartService.loadCartItems();
    int index =
        cartItems.indexWhere((cartItem) => cartItem.itemName == item.name);

    if (index != -1) {
      cartItems[index].quantity++;
    } else {
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
