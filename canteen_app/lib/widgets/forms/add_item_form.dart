import 'package:flutter/material.dart';

class AddItemForm extends StatefulWidget {
  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Item Name'),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: priceController,
          decoration: InputDecoration(labelText: 'Price'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: quantityController,
          decoration: InputDecoration(labelText: 'Quantity'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: () {
            // Add logic to add item
            String name = nameController.text;
            double price = double.parse(priceController.text);
            int quantity = int.parse(quantityController.text);

            print("name: $name, price: $price, quantity: $quantity");

            // Clear text fields
            nameController.clear();
            priceController.clear();
            quantityController.clear();
          },
          child: Text('Add Item'),
        ),
      ],
    );
  }
}
