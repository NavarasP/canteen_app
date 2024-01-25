import 'package:flutter/material.dart';
import 'package:canteen_app/models.dart';

class ItemList extends StatelessWidget {
  final List<CanteenItem> canteenItems;

  ItemList({required this.canteenItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: canteenItems.length,
      itemBuilder: (context, index) {
        var item = canteenItems[index];
        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 50,
              height: double.infinity,
              color: Colors.red,
            ),
            title: Text(item.name),
            subtitle: Row(
              children: [
                Icon(
                  item.isVeg ? Icons.emoji_food_beverage : Icons.emoji_food_beverage_outlined,
                  color: item.isVeg ? Colors.green : Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 3),
                Text('Price: \$${item.price}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                print('Added to Cart: ${item.name}');
              },
              child: const Text('+'),
            ),
          ),
        );
      },
    );
  }
}
