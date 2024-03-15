import 'package:flutter/material.dart';
import 'package:canteen_app/Services/local_service.dart';
import 'package:canteen_app/Services/api_models/users_models.dart';
import 'package:canteen_app/Services/api/canteen_service_user.dart';

class ItemScreenUsers extends StatefulWidget {
  const ItemScreenUsers({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ItemScreenUsersState createState() => _ItemScreenUsersState();
}

class _ItemScreenUsersState extends State<ItemScreenUsers>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CanteenItemStudent> items = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Vegetarian'),
            Tab(text: 'Non-Vegetarian'),
            Tab(text: 'Dessert'),
            Tab(text: 'Snacks'),
            Tab(text: 'Drinks'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCategoryList('Vegetarian'),
          _buildCategoryList('Non-Vegetarian'),
          _buildCategoryList('Dessert'),
          _buildCategoryList('Snacks'),
          _buildCategoryList('Drinks'),
        ],
      ),
    );
  }

  Widget _buildCategoryList(String category) {
    List<CanteenItemStudent> categoryItems = items
        .where((item) => item.category.toLowerCase() == category.toLowerCase())
        .toList();

    return ListView.builder(
      itemCount: categoryItems.length,
      itemBuilder: (context, index) {
        CanteenItemStudent item = categoryItems[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price: ${item.price}'),
              Text('Quantity available: ${item.quantity}'),
              Text('Category: ${item.category}'),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.imageUrl),
          ),
          trailing: ElevatedButton(
            onPressed: () {
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

    await CartService.updateCartItems(cartItems);

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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
