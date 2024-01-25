import 'package:flutter/material.dart';
import 'package:canteen_app/models.dart';



class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
 

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(0, (sum, item) => sum + item.itemPrice * item.itemCount);

    return Scaffold(
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          CartItem cartItem = cartItems[index];

          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(cartItem.itemName),
              subtitle: Row(
                children: [
                  Text('Price: \$${cartItem.itemPrice}'),
                  SizedBox(width: 10),
                  Text('Count: ${cartItem.itemCount}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (cartItem.itemCount > 1) {
                          cartItem.itemCount--;
                        } else {
                          cartItems.removeAt(index);
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        cartItem.itemCount++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: \$${totalAmount.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                // Implement your checkout logic here
                print('Checkout button pressed');
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

