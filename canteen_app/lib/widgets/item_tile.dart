import 'package:flutter/material.dart';
import 'package:canteen_app/widgets/forms/addTocart_form.dart';

class ItemList extends StatelessWidget {
  final List<Map<String, dynamic>> dummyData = [
    {'itemName': 'Burger', 'itemPrice': 5.99, 'isVeg': true},
    {'itemName': 'Pizza', 'itemPrice': 8.99, 'isVeg': false},
    {'itemName': 'Salad', 'itemPrice': 4.99, 'isVeg': true},
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dummyData.length,
      itemBuilder: (context, index) {
        var item = dummyData[index];
        return Card(
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Container(
              width: 50,
              height: double.infinity,
              color: Colors.red, // Set your desired background color
            ),
            title: Text(item['itemName']),
            subtitle: Row(
              children: [
                Icon(
                  item['isVeg']
                      ? Icons.emoji_food_beverage
                      : Icons.emoji_food_beverage_outlined,
                  color: item['isVeg'] ? Colors.green : Colors.red,
                  size: 16,
                ),
                SizedBox(width: 3),
                Text('Price: \$${item['itemPrice']}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                void _showDetailsOverlay(Map<String, dynamic> item) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ItemDetailsOverlay(item: item);
                    },
                  );
                }

                // Implement your add to cart logic here
                // You can use item details for further processing
                print('Added to Cart: ${item['itemName']}');
              },
              child: const Text('+'),
            ),
          ),
        );
      },
    );
  }
}
