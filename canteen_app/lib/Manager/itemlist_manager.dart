import 'package:flutter/material.dart';
import 'package:canteen_app/Models/manager_model.dart';
import 'package:canteen_app/services/api/canteen_service__manager.dart';



class ItemScreen_Manager extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen_Manager> {
  List<CanteenItem_Manager> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      List<CanteenItem_Manager> loadedItems = await CanteenService_Manager().getFoodList_Manager();
      setState(() {
        items = loadedItems;
      });
    } catch (e) {
      // Handle errors
      print('Error loading items: $e');
    }
  }

  Future<void> _createNewItem(Map<String, dynamic> foodData) async {
    try {
      await CanteenService_Manager().createFood(foodData);
      // Refresh the item list after creating a new item
      _loadItems();
    } catch (e) {
      // Handle errors
      print('Error creating item: $e');
    }
  }

  void _showAddItemPopup(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Validate and save the new item data
                Map<String, dynamic> foodData = {
                  'name': nameController.text,
                  'price': double.parse(priceController.text),
                  'quantity': int.parse(quantityController.text),
                };

                // Call the API to create the new item
                _createNewItem(foodData);

                // Close the pop-up
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Special'),
      ),
      body: _buildItemList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the pop-up to add a new item
          _showAddItemPopup(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        CanteenItem_Manager item = items[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price: ${item.price}'),
              Text('Quantity available: ${item.quantity}'),
            ],
          ),
          onTap: () {
            // Show pop-up to edit the selected item
            _showEditItemPopup(context, item);
          },
        );
      },
    );
  }

  void _showEditItemPopup(BuildContext context, CanteenItem_Manager item) {
    TextEditingController nameController =
        TextEditingController(text: item.name);
    TextEditingController priceController =
        TextEditingController(text: item.price.toString());
    TextEditingController quantityController =
        TextEditingController(text: item.quantity.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Validate and save the updated item data
                Map<String, dynamic> foodData = {
                  'name': nameController.text,
                  'price': double.parse(priceController.text),
                  'quantity': int.parse(quantityController.text),
                };

                // Call the API to update the item
                _updateItem(item.id, foodData);

                // Close the pop-up
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateItem(int itemId, Map<String, dynamic> foodData) async {
    try {
      await CanteenService_Manager().updateFood(itemId, foodData);
      // Refresh the item list after updating the item
      _loadItems();
    } catch (e) {
      // Handle errors
      print('Error updating item: $e');
    }
  }
}