import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the User Screen'),
            SizedBox(height: 20),
            ItemList(),
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<Map<String, dynamic>> dummyData = [
    {'itemName': 'Burger', 'itemPrice': 5.99},
    {'itemName': 'Pizza', 'itemPrice': 8.99},
    {'itemName': 'Salad', 'itemPrice': 4.99},
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dummyData.length,
      itemBuilder: (context, index) {
        var item = dummyData[index];
        return ListTile(
          title: Text(item['itemName']),
          subtitle: Text('Price: \$${item['itemPrice']}'),
          // Add more details if needed
        );
      },
    );
  }
}
