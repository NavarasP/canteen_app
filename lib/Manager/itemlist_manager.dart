import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Services/api_models/general_models.dart';
import 'package:canteen_app/Services/Models/manager_model.dart';
import 'package:canteen_app/Services/api/genaral_api_service.dart';
import 'package:canteen_app/Services/api/canteen_service_manager.dart';

class ItemScreenManager extends StatefulWidget {
  const ItemScreenManager({Key? key}) : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreenManager> {
  List<CanteenItemManager> items = [];
  List<FoodCategory> categories = [];
  FoodCategory? selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadItems();
    _loadCategories();
  }

  Future<void> _loadItems() async {
    try {
      List<CanteenItemManager> loadedItems =
          await CanteenServiceManager().getFoodListManager();
      setState(() {
        items = loadedItems;
      });
    } catch (e) {
      // Handle errors
      debugPrint('Error loading items: $e');
    }
  }

  Future<void> _loadCategories() async {
    try {
      List<FoodCategory> loadedCategories =
          (await GenralService().getFoodCategories()).cast<FoodCategory>();
      setState(() {
        categories = loadedCategories;
      });
    } catch (e) {
      // Handle errors
      debugPrint('Error loading categories: $e');
    }
  }

  Future<void> _createNewItem(
      Map<String, dynamic> foodData, File? image) async {
    try {
      await CanteenServiceManager().createFood(foodData, image!);
      // Refresh the item list after creating a new item
      _loadItems();
    } catch (e) {
      // Handle errors
      debugPrint('Error creating item: $e');
    }
  }

  void _showAddItemPopup(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    File? image; // Store the selected image file

    selectImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: selectedCategory,
                hint: Text('Select Category'),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem<FoodCategory>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: selectImage,
                child: Text(image != null ? 'Change Image' : 'Select Image'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Validate and save the new item data
                Map<String, dynamic> foodData = {
                  'name': nameController.text,
                  'price': priceController.text,
                  'quantity': quantityController.text,
                  'category_id': selectedCategory?.id, // Pass the category ID
                  'image': image, // Pass the image file
                };
                // debugPrint(selectedCategory.id as int? );

                // Call the API to create the new item
                _createNewItem(foodData, image);

                // Close the pop-up
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildItemList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the pop-up to add a new item
          _showAddItemPopup(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        CanteenItemManager item = items[index];
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

  void _showEditItemPopup(BuildContext context, CanteenItemManager item) {
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
          title: const Text('Edit Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Validate and save the updated item data
                Map<String, dynamic> foodData = {
                  'name': nameController.text,
                  'price': int.parse(priceController.text),
                  'quantity': int.parse(quantityController.text),
                };

                // Call the API to update the item
                _updateItem(item.id, foodData);

                // Close the pop-up
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateItem(int itemId, Map<String, dynamic> foodData) async {
    try {
      await CanteenServiceManager().updateFood(itemId, foodData);
      // Refresh the item list after updating the item
      _loadItems();
    } catch (e) {
      // Handle errors
      debugPrint('Error updating item: $e');
    }
  }
}
