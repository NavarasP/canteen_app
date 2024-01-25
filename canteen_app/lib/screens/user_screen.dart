import 'package:flutter/material.dart';
import 'package:canteen_app/color_schemes.g.dart';
import 'package:canteen_app/widgets/item_tile.dart';
import 'package:canteen_app/models.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _currentIndex = 0; // Index for the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('User Screen'),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: lightColorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return CartPage(); // Display the cart page
      case 2:
        return ProfilePage(); // Display the profile page
      default:
        return Container(); // Handle other cases as needed
    }
  }

  Widget _buildHomeScreen() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Today\'s Special'),
              const SizedBox(height: 20),
              ItemList(canteenItems: canteenItems),
            ],
          ),
        ),
      ],
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement your cart page UI here
    return Center(
      child: Text('Cart Page'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement your profile page UI here
    return Center(
      child: Text('Profile Page'),
    );
  }
}
