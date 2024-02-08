import 'package:flutter/material.dart';
import 'package:canteen_app/widgets/profile.dart';
import 'package:canteen_app/Users/order_cart.dart';
import 'package:canteen_app/Users/itemlist_user.dart';
import 'package:canteen_app/services/color_schemes.g.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _currentIndex = 0; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
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
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

 AppBar  _buildAppBar() {
    switch (_currentIndex) {
      case 0:
        return AppBar(title: const Text('Home'));
      case 1:
        return AppBar(title: const Text('Cart'));
      case 2:
        return AppBar(title: const Text('Profile'));
      default:
        return AppBar();
    }
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return ItemScreen_Users();
      case 1:
        return CartPage();
      case 2:
        return ProfilePage();
      default:
        return Container();
    }
  }
}