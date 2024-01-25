import 'package:flutter/material.dart';

class ItemDetailsOverlay extends StatelessWidget {
  final Map<String, dynamic> item;
  

  ItemDetailsOverlay({required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['itemName'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['isVeg'] ? 'Veg' : 'Non-Veg',
              style: TextStyle(
                color: item['isVeg'] ? Colors.green : Colors.red,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: \$${item['itemPrice']}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Description: Add your item description here.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement your logic for adding to cart
                    print('Added to Cart: ${item['itemName']}');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add to Cart'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
