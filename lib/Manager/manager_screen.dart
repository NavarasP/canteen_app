import 'package:flutter/material.dart';
import 'package:canteen_app/Manager/orders.dart';
import 'package:canteen_app/Services/widgets/profile.dart';
import 'package:canteen_app/Manager/itemlist_manager.dart';

class CanteenTeamScreen extends StatefulWidget {
  const CanteenTeamScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CanteenTeamScreenState createState() => _CanteenTeamScreenState();
}

class _CanteenTeamScreenState extends State<CanteenTeamScreen> {
  int _currentIndex = 0; // Index for the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // Use a method to build the app bar
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    switch (_currentIndex) {
      case 0:
        return AppBar(title: const Text('Home'));
      case 1:
        return AppBar(title: const Text('Order'));
      case 2:
        return AppBar(title: const Text('Profile'));
      default:
        return AppBar(); // Default app bar for other cases
    }
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const ItemScreenManager();
      case 1:
        return const OrderPageManager();
      case 2:
        return const ProfilePage();
      default:
        return Container();
    }
  }
}
